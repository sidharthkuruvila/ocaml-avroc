open OUnit2
open Generic
open Value
open Errors
open Ctypes

let check_error msg error_no =
  print_string "after";
  if error_no != 0 then begin
      prerr_endline msg;
      prerr_endline ("Error message: " ^ avro_strerror ());
      exit 1
    end

let test1 test_ctxt = 
    print_string "this is a test";
    let bytes = "side" in
    print_string "way before";
    let avro_null = from_voidp avro_value_t null in
    print_string "before";
    check_error "Failed to read bytes" (avro_generic_bytes_new avro_null bytes (Unsigned.Size_t.of_int 3));
    print_string "Hello"; assert_equal true true

let suit = "First Test" >:::
[
  "test1" >:: test1
]

let _ = run_test_tt_main suit
