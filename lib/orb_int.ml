open Orb_internal

class t n =
  object
    val n : int = n

    method to_string : Orb_string.t wrapped =
      Orb_string.create (string_of_int n)

    method add (other : t wrapped) : t wrapped =
      `Some (new t (n + unwrap_value other))

    method mult (other : t wrapped) : t wrapped =
      `Some (new t (n * unwrap_value other))

    method value = n
  end

let create n = `Some (new t n)
