open Orb_internal
open Hidden

type t =
  < print : String.t -> unit
  ; puts : String.t -> unit
  ; read : String.t
  ; remove : unit >
  wrapped

let create name : t =
  `Some
    (object
       val name : string = (unwrap name)#to_string |> unwrap_value

       (* At some point in time it would be nice to remove the duplication in
        * these methods *)
       method print s =
         let oc = open_out_gen [ Open_append; Open_creat ] 0o644 name in
         Printf.fprintf oc "%s" (to_string_unwrap s) ;
         flush oc ;
         close_out oc

       method puts s =
         let oc = open_out_gen [ Open_append; Open_creat ] 0o644 name in
         Printf.fprintf oc "%s\n" (to_string_unwrap s) ;
         flush oc ;
         close_out oc

       method read : String.t =
         let text = ref "" in
         let ic = open_in name in
         let () =
           try
             while true do
               let line = input_line ic in
               text := !text ^ "\n" ^ line
             done
           with
           | End_of_file ->
               close_in ic
         in
         String.create !text

       method remove = Sys.remove name
    end)
