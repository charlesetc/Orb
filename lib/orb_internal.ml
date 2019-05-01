type 'a wrapped = [`Some of 'a]

let unwrap item = match item with `Some v -> v

let unwrap_value orb_value = (unwrap orb_value)#value

let to_string_unwrap x = (unwrap x)#to_string |> unwrap_value

let nil = `Nil
