open Ctypes
open Io
open Schema
open Errors
open Generic
open Value
open Unsigned
open Core
       

let check_error msg error_no =
  if error_no != 0 then begin
      prerr_endline msg;
      prerr_endline ("Error message: " ^ avro_strerror ());
      exit 1
    end

let get_field record index = 
  let field_ptr = allocate_n avro_value ~count:1 in
  let err = (avro_value_get_by_index record (Size_t.of_int index) field_ptr (from_voidp string null)) in
  check_error "Failed to get field" err;
  !@field_ptr

let set_string value str = 
  let err = avro_value_set_string value str in
  check_error "Failed to get field" err


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



let print_person person = 
  let field_ptr = allocate_n avro_value ~count:1 in
  let long_ptr = allocate_n int64_t ~count:1 in
  let byte_ptr_ptr = allocate_n (ptr char) ~count:1 in
  let size_t_ptr = allocate_n size_t ~count:1 in
  check_error "Failed to get field" (avro_value_get_by_index person (Size_t.of_int 0) field_ptr (from_voidp string null));
  check_error "Failed to set string" (avro_value_get_long !@field_ptr long_ptr);
  Core.Std.printf "Id = %d, " (Int64.to_int !@long_ptr);
  check_error "Failed to get field" (avro_value_get_by_index person (Size_t.of_int 1) field_ptr (from_voidp string null));
  check_error "Failed to set string" (avro_value_get_string !@field_ptr byte_ptr_ptr size_t_ptr);
  let first = (string_from_ptr !@byte_ptr_ptr (Size_t.to_int !@size_t_ptr)) in
  Core.Std.printf "First name = %s, " first;
  Core.Std.printf "\n"

let add_person db person_schema first last number age =
  let record_class = avro_generic_class_from_schema person_schema in 
  let value_ptr = allocate_n avro_value ~count:1 in
  check_error "Failed to create fixed" (avro_generic_value_new record_class value_ptr);
  let field_ptr = allocate_n avro_value ~count:1 in
  check_error "Failed to get field" (avro_value_get_by_index !@value_ptr (Size_t.of_int 0) field_ptr (from_voidp string null));
  check_error "Failed to set string" (avro_value_set_long !@field_ptr (Int64.of_int 17));
  set_string (get_field !@value_ptr 1) first;
  set_string (get_field !@value_ptr 1) last;
  set_string (get_field !@value_ptr 1) number;
  check_error "Failed to get field" (avro_value_get_by_index !@value_ptr (Size_t.of_int 4) field_ptr (from_voidp string null));
  check_error "Failed to set int" (avro_value_set_int !@field_ptr (Int32.of_int age));
  check_error "Failed to write into file"  (avro_file_writer_append_value db value_ptr);
  print_person !@value_ptr
    
                          
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
  let number = "123" in 
  let db = !@db_ptr in
  add_person db !@person_schema_ptr "Dante" "Hicks" number 32;
  add_person db !@person_schema_ptr "Randal" "Graves" "(555) 123-5678" 30;
  add_person db !@person_schema_ptr "Veronica" "Loughran" "(555) 123-0987" 28;
  add_person db !@person_schema_ptr "Caitlin" "Bree" "(555) 123-2323" 27;
  add_person db !@person_schema_ptr "Bob" "Silent" "(555) 123-6422" 29;
  add_person db !@person_schema_ptr "Jay" "???" number 26;
  ignore (avro_file_writer_flush db);
  ignore (avro_file_writer_close db);
  Format.printf "hello\n" ;;

let () = main ()
