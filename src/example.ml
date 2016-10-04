
(* open the orb standard *)
open Orb;;

(* a new integer *)
let n = integer 2;;

(* a new vector *)
let v = vector ();;


let ocaml = str "OCAML";;
let is = str "IS";;
let awesome = str "AWESOME!!!";;

let vector_of_strings = vector ();;

(* calling methods *)
vector_of_strings#push awesome;;
vector_of_strings#push is;;
vector_of_strings#push ocaml;;

v#push vector_of_strings;;

puts v;;

(* a new file *)
let f = file (str "text.txt");;

(* file operations *)
f#puts (str "hi there!");;
f#puts (str "hi there!");;
puts f#read;;

f#remove;;
