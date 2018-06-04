
open Orb

(* a new integer *)
let n : int = 2;;

(* a new list *)
let v = list ();;


let ocaml = "OCAML";;
let is = "IS";;
let awesome = "AWESOME!!!";;

let list_of_strings = Orb.List.from_list ["hi"; "there"] ;;

(* calling methods *)
list_of_strings.push awesome;;
list_of_strings += is;;
list_of_strings += ocaml;;

v.push list_of_strings;;

puts v;;

(* a new file *)
let f = file "text.txt";;

(* file operations *)
f.puts "hi there!";;
f.puts "hi there!";;

puts ^ f.read + "\n wowwww";;

puts ^ 5 + 5;;

f.remove;;

let name = "charles" ;;

puts ^ "hi there, " + name + "!!";;
puts ^ 10.2003 * 100.
