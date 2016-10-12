open Asttypes
open Parsetree
open Ast_mapper
open Longident

let orb_mapper argv =
  { default_mapper with
    expr = fun mapper expr ->
      match expr with
      | { pexp_desc = Pexp_constant (Const_int i); pexp_loc = loc } ->
          let integer_constant = Pexp_constant (Const_int i) in
          let int_ident = { expr with pexp_desc = Pexp_ident { txt = Lident "int"; loc = loc } } in
          let int_arguments = [("", {expr with pexp_desc = integer_constant})] in
          let apply_int = Pexp_apply ( int_ident, int_arguments ) in
          { expr with pexp_desc = apply_int }
      | other -> default_mapper.expr mapper other; }

let () =
  register "ppx_orb" orb_mapper
