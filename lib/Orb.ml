
open Unix;;

let str (s : string) = object (self)
  val s = s
  method to_string = self
  method value = s
end

let integer n = object (self)
  val n = n
  method to_string =
    str (string_of_int n)

  method value = n
end

let vector () = object (self)
  val mutable v = []

  method to_string =
    let inner = String.concat " " (List.map (fun o -> o#to_string#value) v) in
    str ("[" ^ inner ^ "]")

  method push o = v <- o::v

  method value = v
end


let puts o = print_endline o#to_string#value;;
let print o = print_string o#to_string#value;;
