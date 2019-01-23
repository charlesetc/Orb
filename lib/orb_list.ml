open Orb_internal

type 'a internal_list =
  [ `Cons of 'a * 'a internal_list
  | `Nil ]

let rec internal_list_of_ocaml_list = function
  | x :: rest ->
      `Cons (x, internal_list_of_ocaml_list rest)
  | [] ->
      `Nil

class ['a] t (initial : 'a internal_list) =
  object (self)
    val mutable v : 'a internal_list = initial

    method to_ocaml_list =
      let rec convert = function
        | `Cons (hd, tl) ->
            hd :: convert tl
        | `Nil ->
            []
      in
      convert v

    (* Alternative, slower map implementation: 
       
        let mapped =
          self#to_ocaml_list |> List.map f |> internal_list_of_ocaml_list
        in
        `Some (new t mapped)
    *)
    method map f : 'b t wrapped =
      let rec map f = function
        | `Cons (hd, tl) ->
            `Cons (f hd, map f tl)
        | `Nil ->
            `Nil
      in
      let mapped = map f v in
      `Some (new t mapped)

    method to_string : Orb_string.t wrapped =
      let inner =
        self#to_ocaml_list
        |> List.map (fun o -> (unwrap o)#to_string)
        |> List.map unwrap_value
        |> String.concat ", "
      in
      Orb_string.create ("[" ^ inner ^ "]")

    method push o = v <- `Cons (o, v)

    (* method pop = match *)
    method value = v
  end

let create lst = `Some (new t (internal_list_of_ocaml_list lst))

let rec cons (hd, rst) =
  (unwrap rst)#push hd ;
  rst

let rec nil () = create []
