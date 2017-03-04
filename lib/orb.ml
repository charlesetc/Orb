
open Sys;;

include Orb_string
include Orb_numeric
include Orb_list
include Orb_file

module String = Orb_string
module Numeric = Orb_numeric
module List = Orb_list
module File = Orb_file

let puts o = print_endline o#to_string#value;;
let print o = print_string o#to_string#value;;

let (+) a b = a#add b;;
let ( * ) a b = a#mult b;;
let ( += ) a b = a#push b;;
let (^) f a = f a;;
