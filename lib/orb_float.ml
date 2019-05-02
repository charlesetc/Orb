open Orb_internal
open Hidden

type t =
  < value : float
  ; to_string : String.t
  ; add : float -> float
  ; mult : float -> float >
  wrapped

let rec create f =
  `Some
    (object (self : 's)
       val f : float = f

       method to_string = Hidden.String.create (string_of_float f)

       method add other = create (self#value +. unwrap_value other)

       method mult other = create (self#value *. unwrap_value other)

       method value = f
    end)
