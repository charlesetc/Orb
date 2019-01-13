open Orb_string

class ['a] file name =
  object (self)
    val name = name

    method print (s : 'a) =
      let oc =
        open_out_gen [Open_append; Open_creat] 0o644 (name#to_string)#value
      in
      Printf.fprintf oc "%s" (s#to_string)#value ;
      flush oc ;
      close_out oc

    method puts (s : 'a) =
      let oc =
        open_out_gen [Open_append; Open_creat] 0o644 (name#to_string)#value
      in
      Printf.fprintf oc "%s\n" (s#to_string)#value ;
      flush oc ;
      close_out oc

    method read =
      let text = ref "" in
      let ic = open_in (name#to_string)#value in
      let () =
        try
          while true do
            let line = input_line ic in
            text := !text ^ "\n" ^ line
          done
        with End_of_file -> close_in ic
      in
      string !text

    method remove = Sys.remove (name#to_string)#value
  end

let file name = new file name
