
open Orb;;

let n = Orb.integer 2;;

let v = Orb.vector ();;


let ocaml = Orb.str "OCAML";;
let is = Orb.str "IS";;
let awesome = Orb.str "AWESOME!!!";;

let vector_of_strings = Orb.vector ();;

vector_of_strings#push awesome;;
vector_of_strings#push is;;
vector_of_strings#push ocaml;;

v#push vector_of_strings;;

Orb.puts v;;
