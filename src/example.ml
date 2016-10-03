
open Orb;;

let n = integer 2;;

let v = vector ();;


let ocaml = str "OCAML";;
let is = str "IS";;
let awesome = str "AWESOME!!!";;

let vector_of_strings = vector ();;

vector_of_strings#push awesome;;
vector_of_strings#push is;;
vector_of_strings#push ocaml;;

v#push vector_of_strings;;

puts v;;

let f = file "text.txt";;

f#puts "hi there!";;
f#puts "hi there!";;
puts f#read;;

f#remove;;
