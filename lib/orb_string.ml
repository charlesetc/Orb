
type _string = string;;

class string s = object (self : 's)
  val s = s

  method to_string = self

  method value = s

  method add (other : 's) = new string (self#value ^ other#to_string#value)

  method mult (other : int) = self (* TODO "hi" * 5 => "hihihihihi" *)
end

let string s = new string s
