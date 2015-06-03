open Ctypes
open Io
open Schema
open Errors
open Generic
open Value
open Unsigned
open Simple


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
  Format.printf "Id = %d, " (Int64.to_int !@long_ptr);
  check_error "Failed to get field" (avro_value_get_by_index person (Size_t.of_int 1) field_ptr (from_voidp string null));
  check_error "Failed to set string" (avro_value_get_string !@field_ptr byte_ptr_ptr size_t_ptr);
  let first = (string_from_ptr !@byte_ptr_ptr (Size_t.to_int !@size_t_ptr)) in
  Format.printf "First name = %s, " first;
  Format.printf "\n"

let add_person db person_schema first last number age =
  let record_class = avro_generic_class_from_schema person_schema in 
  let value_ptr = allocate_n avro_value ~count:1 in
  check_error "Failed to create fixed" (avro_generic_value_new record_class value_ptr);
  set_long !@(get_field !@value_ptr 0) 17;
  set_string !@(get_field !@value_ptr 1) first;
  set_string !@(get_field !@value_ptr 2) last;
  set_string !@(get_field !@value_ptr 3) number;
  set_int !@(get_field !@value_ptr 4) age;
  write_avro_value db value_ptr;
  print_person !@value_ptr
    
                          
let main () =
  let dbname = "quickstop.db" in
  let person_schema_ptr = parse_avro_schema person_schema_str in
  let db_ptr = avro_file_writer !@person_schema_ptr dbname in
  let db = !@db_ptr in
  let number = "123" in 
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
