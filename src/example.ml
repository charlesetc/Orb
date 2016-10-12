
(* open the orb standard *)
include Orb;;

(* a new integer *)
let n : int = 2;;

(* a new list *)
let v = list ();;


let ocaml = string "OCAML";;
let is = string "IS";;
let awesome = string "AWESOME!!!";;

let list_of_strings = list ();;

(* calling methods *)
list_of_strings#push awesome;;
list_of_strings#push is;;
list_of_strings#push ocaml;;

v#push list_of_strings;;

puts v;;

(* a new file *)
let f = file (string "text.txt");;

(* file operations *)
f#puts (string "hi there!");;
f#puts (string "hi there!");;

puts $ f#read + string "\n wowwww";;

puts $ 5 + 5;;

f#remove;;

puts $ float 10.2 * float 10.0
