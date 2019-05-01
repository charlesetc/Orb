open Orb_internal

(* Development guidelines
 * ======================
 * 
 * Every module should create a class with type `t`. The hope is that most
 * users of Orb won't have to interact with classes, but it can be useful to
 * have a type defined for type assertions. This is especially true of core
 * types like integers, strings, etc.
 *
 * Methods on those classes should only ever interact with `wrapped` values.
 * `unwrap` should only ever have to be called when interfacing with OCaml:
 * Orb code should never have to call `unwrap` itself.
 *
 * There should be a `create` function at the end of every module that
 * exposes a function to create a wrapped value (whereas `new t` does not create a
 * wrapped value.)
 * *)

(* Exposed modules *)
module String = Orb_string
module Int = Orb_int
module Float = Orb_float
module List = Orb_list
module File = Orb_file

(* Options *)

let nil = Orb_internal.nil

(* Strings *)

let string = String.create

type string = [`Some of String.t]

(* Integers *)

let int = Int.create

type int = [`Some of Int.t]

(* Floats *)

let float = Float.create

type float = [`Some of Float.t]

(* Lists *)

let list = List.create

(* type 'a list = [`Some of 'a List.t] *)

(* Files *)

let file = File.create

(* these are generic functions that
 * operate on all sorts of data types.
 * They're kinda what make Orb awesome *)

let puts o = (unwrap o)#to_string |> unwrap_value |> print_endline

(* let print o = print_string (o#to_string)#value *)

let ( + ) a b = (unwrap a)#add b

let ( * ) a b = (unwrap a)#mult b

let ( += ) a b = (unwrap a)#push b

let ( ^ ) f a = f a
