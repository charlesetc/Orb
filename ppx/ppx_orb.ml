open Asttypes
open Parsetree
open Ast_mapper
open Longident

let orb_mapper argv =
  { default_mapper with
    expr = fun mapper expr ->
      match expr with
      | { pexp_desc = Pexp_constant (Const_int i); pexp_loc = loc } ->
          { expr with pexp_desc = Pexp_apply ( { expr with pexp_desc = Pexp_ident {txt = Lident "int"; loc = loc}}, [("", {expr with pexp_desc = Pexp_constant (Const_int i)})]) }
      | other -> default_mapper.expr mapper other; }

let () =
  register "ppx_orb" orb_mapper
