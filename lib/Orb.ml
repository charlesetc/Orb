
open Sys;;

class str (s : string) = object (self : 's)
  val s = s

  method to_string = self

  method value = s

  method add (other : 's) = new str (self#value ^ other#to_string#value)
end

let str s = new str s

class integer n = object (self : 's)
  val n = n

  method to_string =
    str (string_of_int n)

  method add (other : 's) = self#value + other#value

  method value = n
end

let integer n = new integer n

class ['a] vector () = object (self)
  val mutable v : 'a list = []

  method to_string =
    let inner = String.concat " " (List.map (fun o -> o#to_string#value) v) in
    str ("[" ^ inner ^ "]")

  method push o = v <- o::v

  method value = v
end

let vector () = new vector ()

class ['a] file name = object (self)
  val name = name

  method print (s : 'a) =
    let oc = open_out_gen [Open_append; Open_creat] 0o644 name#to_string#value in 
    Printf.fprintf oc "%s" s#to_string#value;
    flush oc;
    close_out oc

  method puts (s : 'a) =
    let oc = open_out_gen [Open_append; Open_creat] 0o644 name#to_string#value in 
    Printf.fprintf oc "%s\n" s#to_string#value;
    flush oc;
    close_out oc

  method read =
    let text = ref "" in
    let ic = open_in name#to_string#value in
    let () =
      try while true do 
        let line = input_line ic in
        text := !text ^ "\n" ^ line
      done with End_of_file ->
        close_in ic;
    in
      str !text

  method remove = Sys.remove name#to_string#value

end

let file name = new file name;;

let puts o = print_endline o#to_string#value;;
let print o = print_string o#to_string#value;;
