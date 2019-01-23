open Orb_internal

class t s =
  object
    val s : string = s

    method to_string : t wrapped = `Some (new t s)

    method value = s

    method add (other : t wrapped) : t wrapped =
      let f = s ^ to_string_unwrap other in
      `Some (new t f)
    (* method mult (_other : int) = self *)
    (* TODO "hi" * 5 => "hihihihihi" *)
  end

let create s = `Some (new t s)
