open Orb_string

type _int = int

type _float = float

class int n =
  object (self : 's)
    val n = n

    method to_string = string (string_of_int n)

    method add (other : 's) = new int (self#value + other#value)

    method mult (other : 's) = new int (self#value * other#value)

    method value = n
  end

let int n = new int n

class float f =
  object (self : 's)
    val f = f

    method to_string = string (string_of_float f)

    method add (other : 's) = new float (self#value +. other#value)

    method mult (other : 's) = new float (self#value *. other#value)

    method value = f
  end

let float n = new float n
