open Orb_internal

class t f =
  object (self : 's)
    val f : float = f

    method to_string : Orb_string.t wrapped =
      Orb_string.create (string_of_float f)

    method add (other : 's) = new t (self#value +. other#value)

    method mult (other : 's) = new t (self#value *. other#value)

    method value = f
  end

let create f = `Some (new t f)
