type 'a wrapped = [ `Some of 'a ]

let unwrap (`Some x) = x

let unwrap_value (`Some x) = x#value

let to_string_unwrap (`Some x) = x#to_string |> unwrap_value

let nil = `Nil
