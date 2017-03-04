
open Orb_string

type 'a _list = 'a list;;

class ['a] list () = object (self)
  val mutable v : 'a _list = []

  method to_string =
    let inner = String.concat " " (List.map (fun o -> o#to_string#value) v) in
    string ("[" ^ inner ^ "]")

  method push o = v <- o::v

  method value = v
end

let list () = new list ()

module Orb_list = struct
  (* this Orb_list module contains the methods exposed in 
   * Orb.List but not just Orb. Likewise, it's not Orb.List.list
   * it's just Orb.list *)

  let from_list l =
    let orb_list = list () in
    List.iter (fun item -> orb_list#push item) l ;
    orb_list
end

