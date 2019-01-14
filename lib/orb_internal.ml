type 'a wrapped = [`Some of 'a]

let unwrap item = match item with `Some v -> v

let get_ocaml_value orb_value = (unwrap orb_value)#value
