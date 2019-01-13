open Orb

(* a new integer *)
let n : int = 2

(* a new list *)
let v = list ()

let ocaml = "OCAML"

let is = "IS"

let awesome = "AWESOME!!!"

let list_of_strings = Orb.List.from_list ["hi"; "there"]

(* calling methods *)

let () = list_of_strings.push awesome

let () = list_of_strings += is

let () = list_of_strings += ocaml

let () = v.push list_of_strings

let () = puts v

(* a new file *)
let f = file "text.txt"

(* file operations *)

let () = f.puts "hi there!"

let () = f.puts "hi there!"

let () = puts ^ (f.read + "\n wowwww")

let () = puts ^ (5 + 5)

let () = f.remove

let name = "charles"

let () = puts ^ ("hi there, " + name + "!!")

let () = puts ^ (10.2003 * 100.)

let o = {x = 1000; y = {z = 2}; get_x = self.x}

let () = puts o.get_x

let () = puts o.y.z
