open Orb_internal

class t f =
  object (self : 's)
    val f : float = f

    method to_string : Hidden.String.t =
      Hidden.String.create (string_of_float f)

    method add (other : t wrapped) : t wrapped =
      `Some (new t (self#value +. unwrap_value other))

    method mult (other : t wrapped) : t wrapped =
      `Some (new t (self#value *. unwrap_value other))

    method value = f
  end

let create f = `Some (new t f)
