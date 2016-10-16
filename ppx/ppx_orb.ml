open Asttypes
open Parsetree
open Ast_mapper
open Longident

let ast_default_mapper = default_mapper;;

let gen_pexpr loc desc = { pexp_desc = desc ; pexp_loc = loc; pexp_attributes = [] }

(* int mapper maps ints *)
let int_mapper pexp_desc loc =
  let pexpr = gen_pexpr loc in
  match pexp_desc with
  | Pexp_constant (Const_int i) ->
      let int_ident = pexpr (Pexp_ident { txt = Lident "int"; loc = loc }) in
      let int_arguments = [("", (pexpr pexp_desc))] in
      Some (Pexp_apply ( int_ident, int_arguments ))
  | other ->  None

(* string mapper maps strings *)
let string_mapper pexp_desc loc =
  let pexpr = gen_pexpr loc in
  match pexp_desc with
      | Pexp_constant (Const_string (s, None)) ->
          let string_ident = pexpr (Pexp_ident { txt = Lident "string"; loc = loc }) in
          let string_arguments = [("", (pexpr pexp_desc))] in
          Some (Pexp_apply ( string_ident, string_arguments ))
          (* Some pexp_desc *)
      | other -> None


(* maps record access to method calls and method calls to record access *)
let field_mapper pexp_desc loc =
  (* let pexpr = gen_pexpr loc in *)
  match pexp_desc with
    | Pexp_field ({ pexp_desc = Pexp_ident { txt = Lident receiver; _ } ; _ }, { txt =  Lident field_name; _ }) ->
        Some (Pexp_send ({ pexp_desc = Pexp_ident { txt = Lident receiver; loc = loc } ; pexp_loc = loc ; pexp_attributes = []}, field_name))
    | Pexp_send ({ pexp_desc = Pexp_ident { txt = Lident receiver; _ } ; _ }, field_name) ->
        Some (Pexp_field ({ pexp_desc = Pexp_ident { txt = Lident receiver; loc = loc } ; pexp_loc = loc ; pexp_attributes = [] }, { txt =  Lident field_name; loc = loc }))
    | other -> None

let alternative_mappers = [string_mapper; int_mapper; field_mapper]

let ast_mapper argv =
  { default_mapper with
    expr = fun mapper expr ->
      let mapper_chain = ref alternative_mappers in
      let result = ref None in
      while (!result = None) && (List.length !mapper_chain <> 0) do
        match !mapper_chain with
        | [] -> result := None
        | chained_mapper :: rest -> mapper_chain := rest ; result := chained_mapper expr.pexp_desc expr.pexp_loc
      done ; match !result with
      | None -> default_mapper.expr mapper expr
      | Some x -> { expr with pexp_desc = x } }

let () =
  register "ppx_orb" ast_mapper;;
