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
                  ({txt = fieldname; loc}, Public, Cfk_concrete (Fresh, fexp))
            } )
          fields
      in
      Some
        { expr with
          pexp_desc =
            Pexp_object
              { pcstr_self =
                  { ppat_desc = Ppat_var {txt = "self"; loc = expr.pexp_loc}
                  ; ppat_loc = expr.pexp_loc
                  ; ppat_attributes = [] }
              ; pcstr_fields = fields } }
  | _ ->
      None

(* maps record access to method calls and method calls to record access *)
let field_pass expr =
  match expr.pexp_desc with
  | Pexp_field (reciever, field) ->
      let field = {field with txt = Longident.last field.txt} in
      Some {expr with pexp_desc = Pexp_send (reciever, field)}
  | Pexp_send (reciever, field) ->
      let field = {field with txt = Longident.parse field.txt} in
      Some {expr with pexp_desc = Pexp_field (reciever, field)}
  | _ ->
      None

let single_passes = [string_pass; int_pass; float_pass]

(* (1* This was written before ppxlib drivers were mainstream, *)
(*  * I bet this could be refactored to use them instead. *1) *)
(* let rec orb_expr passes mapper expr = *)
(*   match passes with *)
(*   | [] -> *)
(*       default_mapper.expr mapper expr *)
(*   | (pass_name, pass) :: rest -> *)
(*     ( match pass expr with *)
(*     | Some expr -> *)
(*         Pprintast.expression Format.std_formatter expr ; *)
(*         print_endline (pass_name ^ " pass \n") ; *)
(*         (1* orb_expr rest mapper expr *1) *)
(*         expr *)
(*     | None -> *)
(*         orb_expr rest mapper expr ) *)

let run_object_pass mapper expr =
  let recurse = Ast_mapper.default_mapper.expr mapper in
  let expr = match object_pass expr with Some expr -> expr | None -> expr in
  let expr = match field_pass expr with Some expr -> expr | None -> expr in
  match (string_pass expr, int_pass expr, float_pass expr) with
  | Some expr, _, _ ->
      expr
  | _, Some expr, _ ->
      expr
  | _, _, Some expr ->
      expr
  | None, None, None ->
      recurse expr

let orb_mapper () = {default_mapper with expr = run_object_pass}

let () =
  Migrate_parsetree.Driver.register
    ~name:"ppx_orb"
    Migrate_parsetree.Versions.ocaml_407
    (fun _config _cookies -> orb_mapper () )
