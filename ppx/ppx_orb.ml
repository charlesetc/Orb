open Migrate_parsetree.Ast_407
open Asttypes
open Parsetree
open Ast_mapper
open Longident

let int_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  | Pexp_constant (Pconst_integer _) ->
      Some [%expr Orb.int [%e expr]]
  | _ ->
      None

let float_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  | Pexp_constant (Pconst_float _) ->
      Some [%expr Orb.float [%e expr]]
  | _ ->
      None

let string_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  | Pexp_constant (Pconst_string _) ->
      Some [%expr Orb.string [%e expr]]
  | _ ->
      None

let list_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  | Pexp_construct ({ txt = Lident "::"; _ }, Some expr) ->
      Some [%expr Orb.List.cons [%e expr]]
  | Pexp_construct ({ txt = Lident "[]"; _ }, None) ->
      Some [%expr Orb.List.empty ()]
  | _ ->
      None

let object_pass expr =
  match expr.pexp_desc with
  (* I'm not sure what the None represent here. *)
  | Pexp_record (fields, None) ->
      let fields =
        List.map
          (fun (lident, fexp) ->
            let loc = lident.loc in
            let longident = lident.txt in
            let fieldname =
              match longident with
              | Lident fieldname ->
                  fieldname
              | _ ->
                  raise
                    (Failure
                       "Unable to covert a qualified record field into an \
                        object.")
            in
            { pcf_loc = lident.loc
            ; pcf_attributes = []
            ; pcf_desc =
                Pcf_method
                  ({ txt = fieldname; loc }, Public, Cfk_concrete (Fresh, fexp))
            } )
          fields
      in
      let expr =
        { expr with
          pexp_desc =
            Pexp_object
              { pcstr_self =
                  { ppat_desc =
                      Ppat_var { txt = "_orb_self"; loc = expr.pexp_loc }
                  ; ppat_loc = expr.pexp_loc
                  ; ppat_attributes = []
                  }
              ; pcstr_fields = fields
              }
        }
      in
      let loc = expr.pexp_loc in
      Some [%expr `Some [%e expr]]
  | _ ->
      (* note: It could be nice to turn objects into record literals when
         * needed.*)
      None

(* maps record access to method calls and method calls to record access *)
let field_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  | Pexp_field
      ( ( { pexp_desc = Pexp_ident ({ txt = Lident "self"; _ } as ident); _ }
        as receiver )
      , field ) ->
      (* Do not try to unwrap `self`.
       * It's not easy to wrap it in a `Some... if this becomes important
       * try instead to defined a method on every object that wraps self.
       * *)
      let field = { field with txt = Longident.last field.txt } in
      let receiver =
        { receiver with
          pexp_desc = Pexp_ident { ident with txt = Lident "_orb_self" }
        }
      in
      Some { expr with pexp_desc = Pexp_send (receiver, field) }
  | Pexp_field (reciever, field) ->
      let reciever = [%expr match [%e reciever] with `Some a -> a] in
      let field = { field with txt = Longident.last field.txt } in
      Some { expr with pexp_desc = Pexp_send (reciever, field) }
  | Pexp_send (reciever, field) ->
      let field = { field with txt = Longident.parse field.txt } in
      Some { expr with pexp_desc = Pexp_field (reciever, field) }
  | _ ->
      None

let map_expr mapper expr =
  (* First try to match against an expression that has subexpressions *)
  let expr = match object_pass expr with Some expr -> expr | None -> expr in
  let expr = match field_pass expr with Some expr -> expr | None -> expr in
  let expr = match list_pass expr with Some expr -> expr | None -> expr in
  (* Then try to match against leaf expressions *)
  match (string_pass expr, int_pass expr, float_pass expr) with
  | Some expr, _, _ ->
      expr
  | _, Some expr, _ ->
      expr
  | _, _, Some expr ->
      expr
  | None, None, None ->
      (* If none of the literals match, map with the ast default mapper. *)
      Ast_mapper.default_mapper.expr mapper expr

let orb_mapper () = { default_mapper with expr = map_expr }

let () =
  Migrate_parsetree.Driver.register
    ~name:"ppx_orb"
    Migrate_parsetree.Versions.ocaml_407
    (fun _config _cookies -> orb_mapper ())
