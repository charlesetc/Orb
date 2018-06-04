open Asttypes
open Parsetree
open Ast_mapper
open Longident

let int_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  | Pexp_constant (Pconst_integer _) ->
      Some [%expr Orb.int [%e expr]]
  | _ ->  None

let float_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  | Pexp_constant (Pconst_float _) ->
      Some [%expr Orb.float [%e expr]]
  | _ ->  None

let string_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  | Pexp_constant (Pconst_string _) ->
      Some [%expr Orb.string [%e expr]]
  | _ ->  None

(* maps record access to method calls and method calls to record access *)
let field_pass expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
    | Pexp_field (reciever, field) ->
        let field = {field with txt = Longident.last field.txt} in
        Some ({expr with pexp_desc = Pexp_send (reciever, field)})
    | Pexp_send (reciever, field) ->
        let field = {field with txt = Longident.parse field.txt} in
        Some ({expr with pexp_desc = Pexp_field (reciever, field)})
    | _ -> None

let all_passes = [field_pass; string_pass; int_pass; float_pass]

let rec orb_expr passes mapper expr = match passes with
 | [] -> default_mapper.expr mapper expr
 | pass :: rest -> (match pass expr with
      | Some expr -> expr
      | None -> orb_expr rest mapper expr)

let orb_mapper () =
  { default_mapper with expr = orb_expr all_passes }

let () =
  Migrate_parsetree.Driver.register ~name:"ppx_orb"
    Migrate_parsetree.Versions.ocaml_406 (
      fun _config _cookies -> orb_mapper ()
    )
