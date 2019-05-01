open Orb

(* a new integer *)
let n = { a = { b = 2 } }

let () = puts (n.a.b + 3)

(* a new list *)
let v = []

let ocaml = "OCAML"

let is = "IS"

let awesome = "AWESOME!!!"

let list_of_strings = [ "hi"; "there" ]

(* calling methods *)

let () = list_of_strings.push awesome

let () = list_of_strings += is

let () = list_of_strings += ocaml

let () = v.push list_of_strings

let () = v.push [ "yo"; "pretty cool" ]

let () = puts v

(* a new file *)
let f = file "text.txt"

(* file operations *)

let () = f.puts "hi there!"

let () = f.puts "hi there!"

let () = puts ^ ("this was read from a file: (" + f.read + ")")

let () = puts ^ (5 + 5)

let () = f.remove

let name = "charles"

let () = puts ^ ("hi there, " + name + "!!")

let () = puts ^ (10.2003 * 100.)

let o = { x = 1000; y = { z = 2 }; get_x = self.x }

let () = puts o.get_x

let () = puts o.y.z

let () = puts { var = 23 }.var
