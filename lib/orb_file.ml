open Orb_internal

let create name =
  `Some
    (object (self)
       val name : string = (unwrap name)#to_string |> unwrap_value

       (* At some point in time it would be nice to remove the duplication in
     * these methods *)
       method print (s : 'a) =
         let oc = open_out_gen [Open_append; Open_creat] 0o644 name in
         Printf.fprintf oc "%s" (to_string_unwrap s) ;
         flush oc ;
         close_out oc

       method puts (s : 'a) : unit =
         let oc = open_out_gen [Open_append; Open_creat] 0o644 name in
         Printf.fprintf oc "%s" (to_string_unwrap s) ;
         flush oc ;
         close_out oc

       method read : Orb_string.t wrapped =
         let text = ref "" in
         let ic = open_in name in
         let () =
           try
             while true do
               let line = input_line ic in
               text := !text ^ "\n" ^ line
             done
           with End_of_file -> close_in ic
         in
         Orb_string.create !text

       method remove = Sys.remove name
    end)
