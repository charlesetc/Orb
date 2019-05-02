open Orb_internal

type orb_string =
  < value : string
  ; to_string : orb_string
  ; add : orb_string -> orb_string
  ; mult : orb_int -> orb_string >
  wrapped

and orb_int =
  < value : int
  ; to_string : orb_string
  ; add : orb_int -> orb_int
  ; mult : orb_int -> orb_int >
  wrapped

let rec orb_string s : orb_string =
  `Some
    (object (self)
       val s : string = s

       method to_string : orb_string = orb_string s

       method value = s

       method add (other : orb_string) = orb_string (s ^ unwrap_value other)

       method mult (i : orb_int) =
         match unwrap_value i with
         | 0 ->
             orb_string ""
         | 1 ->
             `Some self
         | i when i > 1 ->
             self#add (self#mult (orb_int (i - 1)))
         | _ ->
             raise (Failure "string.mult called with negative value")
    end)

and orb_int n : orb_int =
  `Some
    (object
       val n : int = n

       method to_string = orb_string (string_of_int n)

       method add other = orb_int (n + unwrap_value other)

       method mult other = orb_int (n * unwrap_value other)

       method value = n
    end)

module Int = struct
  type t = orb_int

  let create i = orb_int i
end

module String = struct
  type t = orb_string

  let create s = orb_string s
end
