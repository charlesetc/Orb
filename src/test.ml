
include Orb;;

puts (2 + 2)

let f x = x * 2

let g x = puts x

let () =
  g ^ f ^ 8
