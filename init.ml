(* Added by OPAM. *)
let string a = a;;
let () =
  try Topdirs.dir_directory "./mytoplevel"
  with Not_found -> ()
;;



(* orb prompt *)
#require "lambda-term";;
let markup = [LTerm_text.S "Orb" ; LTerm_text.B_fg (LTerm_style.cyan); LTerm_text.S " # "] in
let prompt = LTerm_text.eval markup in
UTop.prompt := fst (React.S.create prompt);;

UTop.add_keyword "puts";;
#directory "./_build/lib";;
#load "orb_string.cmo";;
#load "orb_numeric.cmo";;
#load "orb_list.cmo";;
#load "orb_file.cmo";;
#load "orb.cma";;
include Orb;;
