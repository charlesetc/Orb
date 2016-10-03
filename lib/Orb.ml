
open Sys;;

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

let file name = object (self)
  val name = name

  method print s =
    let oc = open_out_gen [Open_append; Open_creat] 0o644 name in 
    Printf.fprintf oc "%s" s;
    flush oc;
    close_out oc

  method puts s =
    let oc = open_out_gen [Open_append; Open_creat] 0o644 name in 
    Printf.fprintf oc "%s\n" s;
    flush oc;
    close_out oc

  method read =
    let text = ref "" in
    let ic = open_in name in
    let () =
      try while true do 
        let line = input_line ic in
        text := !text ^ "\n" ^ line
      done with End_of_file ->
        close_in ic;
    in
      str !text

  method remove = Sys.remove name

end


let puts o = print_endline o#to_string#value;;
let print o = print_string o#to_string#value;;
