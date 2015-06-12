open Ocamlbuild_plugin
let () =
  dispatch (function
    | Before_options ->
      Options.use_ocamlfind := true
    | After_rules ->
      let params = 
      	["-cclib"; "-lavro"; "-cclib"; "-L/usr/local/Cellar/avro-c/1.7.7/lib"] in
      let flags = List.map (fun x-> A x) params in
      flag ["ocaml"; "link"] (S flags);
    | _ -> ())