
include Orb

let f x = x * 2

let g x = puts x

let () =
  g ^ f ^ 8
