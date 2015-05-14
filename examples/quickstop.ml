open Ctypes
open Io
open Schema
open Errors
open Generic

       


let person_schema_str =
"{\"type\":\"record\",\
  \"name\":\"Person\",\
  \"fields\":[\
     {\"name\": \"ID\", \"type\": \"long\"},\
     {\"name\": \"First\", \"type\": \"string\"},\
     {\"name\": \"Last\", \"type\": \"string\"},\
     {\"name\": \"Phone\", \"type\": \"string\"},\
     {\"name\": \"Age\", \"type\": \"int\"}]}"

let quickstop_codec = "null"

let check_error msg error_no =
  if error_no != 0 then begin
      prerr_endline msg;
      prerr_endline ("Error message: " ^ avro_strerror ());
      exit 1
    end


let add_person db string string string age =
  ()
    
                          
let main () =
  let person_schema_ptr = allocate avro_schema_t null in
  let db_ptr = allocate avro_file_writer_t null in
  let dbname = "quickstop.db" in
  check_error "Unable to parse person schema"
        (avro_schema_from_json_literal
     person_schema_str person_schema_ptr);
  let person_schema = !@person_schema_ptr in
  check_error "There was an error creating db"
        (avro_file_writer_create_with_codec
     dbname person_schema db_ptr quickstop_codec
     (Unsigned.Size_t.of_int 0));
  let db = !@db_ptr in
  Format.printf "hello\n" ;;

let () = main ()
