
open Sys;;

type _int = int;;
type _string = string;;
type _float = float;;
type 'a _list = 'a list;;

let ($) f a = f a;;

class string s = object (self : 's)
  val s = s

  method to_string = self

  method value = s

  method add (other : 's) = new string (self#value ^ other#to_string#value)

  method mult (other : int) = self (* TODO "hi" * 5 => "hihihihihi" *)
end

let string s = new string s

class int n = object (self : 's)
  val n = n

  method to_string =
    string (string_of_int n)

  method add (other : 's) = new int (self#value + other#value)

  method mult (other : 's) = new int (self#value * other#value)

  method value = n
end

let int n = new int n

class float f = object (self : 's)
  val f = f
  
  method to_string =
    string $ string_of_float f

  method add (other : 's) = new float (self#value +. other#value)

  method mult (other : 's) = new float (self#value *. other#value)

  method value = f
end

let float n = new float n

class ['a] list () = object (self)
  val mutable v : 'a _list = []

  method to_string =
    let inner = String.concat " " (List.map (fun o -> o#to_string#value) v) in
    string ("[" ^ inner ^ "]")

  method push o = v <- o::v

  method value = v
end

let list () = new list ()

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
      string !text

  method remove = Sys.remove name#to_string#value

end

let file name = new file name;;

let puts o = print_endline o#to_string#value;;
let print o = print_string o#to_string#value;;

let (+) a b = a#add b;;
let ( * ) a b = a#mult b;;
