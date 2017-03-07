
open Dom_html

(* this will change entirely *)
let rec generate_html polymorphic_ooze = match polymorphic_ooze with
| `p contents -> "got contents!" ^ String.concat "\n" (List.map generate_html contents)
| `div contents -> "got div!" ^ String.concat "\n" (List.map generate_html contents)
| `text (str : string) -> str
| `h1 contents -> "got h1!"
| `h2 contents -> "got h2!"
| `h3 contents -> "got h3!"
| `h4 contents -> "got h4!"
| `h5 contents -> "got h5!"
| `h6 contents -> "got h6!"

let () =
  (* example html data *)
  let html_data = `div [
    `p [`text "hi there"] ;
    `h1 [`text "you okay?"] ;
    `p [`text "hi there"] ;
    `h3 [`text "last thing I swear"] ;
    `p [`text "hi there"] ;
  ] in
  Dom_html.window##alert (generate_html html_data |> Js.string)
