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
  field_ptr

let set_string value str = 
  let err = avro_value_set_string value str in
  check_error "Failed to get field" err

let set_long value number = 
	let err = avro_value_set_long value (Int64.of_int number) in
	check_error "Failed to set long" err

let set_int value number = 
	let err = avro_value_set_int value (Int32.of_int number) in
	check_error "Failed to set int" err

let write_avro_value file value =
	let err = avro_file_writer_append_value file value in
	check_error "Failed to write into file" err

let parse_avro_schema json = 
	let schema_ptr = allocate avro_schema_t null in
	let err = avro_schema_from_json_literal json schema_ptr in
	check_error "Unable to parse schema" err;
	schema_ptr

let avro_file_writer schema filename = 
	let file_ptr = allocate avro_file_writer_t null in
	let err = avro_file_writer_create_with_codec 
		filename schema file_ptr "null" (Unsigned.Size_t.of_int 0) in
	check_error "Unable to create writer" err;
	file_ptr