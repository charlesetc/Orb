open Orb_internal

class t n =
  object (self)
    val n : int = n

    method to_string : Orb_string.t wrapped =
      Orb_string.create (string_of_int n)

    method add (other : t wrapped) : t wrapped =
      `Some (new t (n + (unwrap other)#value))

    method mult (other : t wrapped) : t wrapped =
      `Some (new t (n * (unwrap other)#value))

    method value = n
  end

let create n = `Some (new t n)
