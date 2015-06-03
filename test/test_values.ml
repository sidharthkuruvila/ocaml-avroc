open OUnit2
open Generic
open Value
open Errors
open Ctypes
open Foreign
open Unsigned
open Schema


let check_error msg error_no =
  if error_no != 0 then begin
      prerr_endline msg;
      prerr_endline ("Error message: " ^ avro_strerror ());
      exit 1
    end

let test_boolean _ = 
    let original = 0 in
    let updated = 0 in
    let boolean_ptr = allocate int 0 in
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create double" (avro_generic_boolean_new value_ptr original);
    check_error "Failed to fetch double" (avro_value_get_boolean !@value_ptr boolean_ptr);
    assert_equal original !@boolean_ptr;
    check_error "Failed to reset double" (avro_value_reset !@value_ptr);
    check_error "Failed to fetch double" (avro_value_get_boolean !@value_ptr boolean_ptr);
    assert_equal 0 !@boolean_ptr;
    check_error "Failed to set double"  (avro_value_set_boolean !@value_ptr updated);
    check_error "Failed to fetch test_double" (avro_value_get_boolean !@value_ptr boolean_ptr);
    assert_equal updated !@boolean_ptr;
    avro_value_decref value_ptr

let test_double _ = 
    let original = 10.4 in
    let updated = 3.56 in
    let number_ptr = allocate double 0.0 in
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create double" (avro_generic_double_new value_ptr original);
    check_error "Failed to fetch double" (avro_value_get_double !@value_ptr number_ptr);
    assert_equal original !@number_ptr;
    check_error "Failed to reset double" (avro_value_reset !@value_ptr);
    check_error "Failed to fetch double" (avro_value_get_double !@value_ptr number_ptr);
    assert_equal 0.0 !@number_ptr;
    check_error "Failed to set double"  (avro_value_set_double !@value_ptr updated);
    check_error "Failed to fetch test_double" (avro_value_get_double !@value_ptr number_ptr);
    assert_equal updated !@number_ptr;
    avro_value_decref value_ptr

let test_float _ = 
    let original = 10.4 in
    let updated = 3.56 in
    let number_ptr = allocate float 0.0 in
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create double" (avro_generic_float_new value_ptr original);
    check_error "Failed to fetch double" (avro_value_get_float !@value_ptr number_ptr);
    assert_bool "Floats do not match" (cmp_float (!@number_ptr) original);
    check_error "Failed to reset double" (avro_value_reset !@value_ptr);
    check_error "Failed to fetch double" (avro_value_get_float !@value_ptr number_ptr);
    assert_equal 0.0 !@number_ptr;
    check_error "Failed to set double"  (avro_value_set_float !@value_ptr updated);
    check_error "Failed to fetch test_double" (avro_value_get_float !@value_ptr number_ptr);
    assert_bool "Fail!" (cmp_float (!@number_ptr) updated);
    avro_value_decref value_ptr

let test_int _ = 
    let original = Int32.of_int 10 in
    let updated = Int32.of_int 3 in
    let number_ptr = allocate int32_t (Int32.of_int 0) in
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create int" (avro_generic_int_new value_ptr original);
    check_error "Failed to fetch int" (avro_value_get_int !@value_ptr number_ptr);
    assert_equal original !@number_ptr;
    check_error "Failed to reset int" (avro_value_reset !@value_ptr);
    check_error "Failed to fetch int" (avro_value_get_int !@value_ptr number_ptr);
    assert_equal (Int32.of_int 0) !@number_ptr;
    check_error "Failed to set int"  (avro_value_set_int !@value_ptr updated);
    check_error "Failed to fetch int" (avro_value_get_int !@value_ptr number_ptr);
    assert_equal updated !@number_ptr;
    avro_value_decref value_ptr

let test_long _ = 
    let original = Int64.of_int 10 in
    let updated = Int64.of_int 3 in
    let number_ptr = allocate int64_t (Int64.of_int 0) in
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create int" (avro_generic_long_new value_ptr original);
    check_error "Failed to fetch int" (avro_value_get_long !@value_ptr number_ptr);
    assert_equal original !@number_ptr;
    check_error "Failed to reset int" (avro_value_reset !@value_ptr);
    check_error "Failed to fetch int" (avro_value_get_long !@value_ptr number_ptr);
    assert_equal (Int64.of_int 0) !@number_ptr;
    check_error "Failed to set int"  (avro_value_set_long !@value_ptr updated);
    check_error "Failed to fetch int" (avro_value_get_long !@value_ptr number_ptr);
    assert_equal updated !@number_ptr;
    avro_value_decref value_ptr

let test_null _ =
    (*Leaving unimplemented for now need to figure out what to test*)
    assert_equal true true

let test_string _ = 
    let original = "This is a test string" in
    let updated = "This is a replacement string" in
    let short_text = "" in
    let smaller_text_len = 10 in
    let string_ptr = allocate string "" in 
    let byte_ptr_ptr = allocate_n (ptr char) ~count:1 in
    let size_t_ptr = allocate_n size_t ~count:1 in
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create string" (avro_generic_string_new value_ptr original);
    check_error "Failed to fetch string" (avro_value_get_string !@value_ptr byte_ptr_ptr size_t_ptr);
    (* Avro includes the trailing 0 in it's size check so we discount that *)
    let result_str = string_from_ptr !@byte_ptr_ptr ((Size_t.to_int !@size_t_ptr) - 1) in
    assert_equal original result_str;
    check_error "Failed to set string" (avro_value_set_string !@value_ptr updated);
    check_error "Failed to fetch string" (avro_value_get_string !@value_ptr byte_ptr_ptr size_t_ptr);
    let result_str = string_from_ptr !@byte_ptr_ptr ((Size_t.to_int !@size_t_ptr) - 1) in
    assert_equal updated result_str;
    check_error "Failed to set string" (avro_value_set_string_len!@value_ptr updated (Size_t.of_int smaller_text_len));
    check_error "Failed to fetch string" (avro_value_get_string !@value_ptr byte_ptr_ptr size_t_ptr);
    let result_str = string_from_ptr !@byte_ptr_ptr (Size_t.to_int !@size_t_ptr) in
    assert_equal "This is a " result_str;
    avro_value_decref value_ptr

let test_array _ = 
    let double_schema = avro_schema_double () in
    let array_schema = avro_schema_array double_schema in
    let array_class = avro_generic_class_from_schema array_schema in
    let array_value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create array" (avro_generic_value_new array_class array_value_ptr);
    let element = allocate_n avro_value ~count:1 in
    let new_index = allocate_n size_t ~count:1 in
    check_error "Failed to add element" (avro_value_append !@array_value_ptr element new_index);
    check_error "Failed to add element" (avro_value_append !@array_value_ptr element new_index);
    check_error "Failed to set double" (avro_value_set_double !@element 3.0);
    assert_equal 1 (Size_t.to_int !@new_index);
    let size_t_ptr = allocate_n size_t ~count:1 in
    check_error "Failed to get size of array" (avro_value_get_size !@array_value_ptr size_t_ptr);
    assert_equal 2 (Size_t.to_int !@size_t_ptr);
    check_error "Failed to get element" (avro_value_get_by_index !@array_value_ptr (Size_t.of_int 1) element (from_voidp string null));
    ignore (avro_schema_decref double_schema);
    ignore (avro_schema_decref array_schema);
    avro_value_iface_decref array_class

let test_enum _ = 
    let enum_schema_ptr = allocate avro_schema_t null in
    let schema_str = "{" ^
      "\"type\": \"enum\"," ^
      "\"name\": \"suits\"," ^
      "\"symbols\": [\"CLUBS\",\"DIAMONDS\",\"HEARTS\",\"SPADES\"]"  ^
    "}" in
    check_error "Failed to read avro schema" (avro_schema_from_json_literal schema_str enum_schema_ptr);
    let enum_class = avro_generic_class_from_schema !@enum_schema_ptr in 
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create string" (avro_generic_value_new enum_class value_ptr);
    let updated = 2 in
    let number_ptr = allocate int 0 in
    check_error "Failed to fetch int" (avro_value_get_enum !@value_ptr number_ptr);
    assert_equal 0 !@number_ptr;
    check_error "Failed to reset int" (avro_value_reset !@value_ptr);
    check_error "Failed to fetch int" (avro_value_get_enum !@value_ptr number_ptr);
    assert_equal 0 !@number_ptr;
    check_error "Failed to set int"  (avro_value_set_enum !@value_ptr updated);
    check_error "Failed to fetch int" (avro_value_get_enum !@value_ptr number_ptr);
    assert_equal updated !@number_ptr;
    avro_value_decref value_ptr

let test_fixed _ = 
    let fixed_schema_ptr = allocate avro_schema_t null in
    let schema_str = "{" ^
    "  \"type\": \"fixed\"," ^
    "  \"name\": \"ipv4\"," ^
    "  \"size\": 4" ^
    "}" in 
    check_error "Failed to read avro schema" (avro_schema_from_json_literal schema_str fixed_schema_ptr);
    let fixed_class = avro_generic_class_from_schema !@fixed_schema_ptr in 
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create fixed" (avro_generic_value_new fixed_class value_ptr);
    let updated = allocate_n char ~count:4 in
    (updated +@ 0) <-@ 'a';
    (updated +@ 1) <-@ 'b';
    (updated +@ 2) <-@ 'c';
    (updated +@ 3) <-@ 'd';
    check_error "Failed to set fixed" (avro_value_set_fixed !@value_ptr (to_voidp updated) (Size_t.of_int 4));
    let result = allocate_n (ptr void) ~count:1 in
    let size_t_ptr = allocate_n size_t ~count:1 in 
    check_error "Failed to set fixed" (avro_value_get_fixed !@value_ptr result size_t_ptr);
    assert_equal 4 (Size_t.to_int !@size_t_ptr);
    avro_value_decref value_ptr

let test_map _ = 
    let double_schema = avro_schema_double () in
    let map_schema = avro_schema_map double_schema in
    let map_class = avro_generic_class_from_schema map_schema in
    let map_value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create array" (avro_generic_value_new map_class map_value_ptr);
    let element = allocate_n avro_value ~count:1 in
    let new_index = allocate_n size_t ~count:1 in
    let is_new = allocate_n int ~count:1 in
    check_error "Failed to add element" (avro_value_add !@map_value_ptr "key1" element new_index is_new);
    assert_equal 1 !@is_new;
    check_error "Failed to add element" (avro_value_add !@map_value_ptr "key1" element new_index is_new);
    assert_equal 0 !@is_new;
    check_error "Failed to set double" (avro_value_set_double !@element 3.0);
    assert_equal 0 (Size_t.to_int !@new_index);
    check_error "Failed to get element" (avro_value_get_by_index !@map_value_ptr (Size_t.of_int 0) element (from_voidp string null));
    let size_t_ptr = allocate_n size_t ~count:1 in
    avro_value_iface_decref map_class  

let test_record _ =
    let record_schema_ptr = allocate avro_schema_t null in
    let schema_str = "{" ^
    "  \"type\": \"record\"," ^
    "  \"name\": \"test\"," ^
    "  \"fields\": [" ^
    "    { \"name\": \"b\", \"type\": \"boolean\" }," ^
    "    { \"name\": \"i\", \"type\": \"int\" }," ^
    "    { \"name\": \"s\", \"type\": \"string\" }," ^
    "    { \"name\": \"ds\", \"type\": " ^
    "      { \"type\": \"array\", \"items\": \"double\" } }," ^
    "    { \"name\": \"sub\", \"type\": " ^
    "      {" ^
    "        \"type\": \"record\"," ^
    "        \"name\": \"subtest\"," ^
    "        \"fields\": [" ^
    "          { \"name\": \"f\", \"type\": \"float\" }," ^
    "          { \"name\": \"l\", \"type\": \"long\" }" ^
    "        ]" ^
    "      }" ^
    "    }," ^
    "    { \"name\": \"nested\", \"type\": [\"null\", \"test\"] }" ^
    "  ]" ^
    "}"; in
    check_error "Failed to read avro schema" (avro_schema_from_json_literal schema_str record_schema_ptr);
    let record_class = avro_generic_class_from_schema !@record_schema_ptr in 
    let value_ptr = allocate_n avro_value ~count:1 in
    check_error "Failed to create fixed" (avro_generic_value_new record_class value_ptr);
    let size_t_ptr = allocate_n size_t ~count:1 in
    check_error "Failed to get size of record" (avro_value_get_size !@value_ptr size_t_ptr);
    assert_equal 6 (Size_t.to_int !@size_t_ptr);
    let field_ptr = allocate_n avro_value ~count:1 in
    let element_ptr = allocate_n avro_value ~count:1 in
    let subfield_ptr = allocate_n avro_value ~count:1 in
    let branch_ptr = allocate_n avro_value ~count:1 in
    let field_name_ptr = allocate_n string ~count:1 in 
    let field_index_ptr = allocate_n size_t ~count:1 in 
    check_error "Failed to get field" (avro_value_get_by_index !@value_ptr (Size_t.of_int 0) field_ptr (from_voidp string null));
    check_error "Failed to set boolean" (avro_value_set_boolean !@field_ptr 1);
    check_error "Failed to get field" (avro_value_get_by_index !@value_ptr (Size_t.of_int 1) field_ptr field_name_ptr);
    check_error "Failed to set boolean" (avro_value_set_int !@field_ptr (Int32.of_int 42));
    assert_equal "i" !@field_name_ptr;
    check_error "Failed to get field"  (avro_value_get_by_index !@value_ptr (Size_t.of_int 2) field_ptr (from_voidp string null));
    check_error "Failed to set string" (avro_value_set_string !@field_ptr "hello");
    check_error "Failed to get field"  (avro_value_get_by_name !@value_ptr "i" field_ptr field_index_ptr);
    assert_equal 1 (Size_t.to_int !@field_index_ptr);

    check_error "Failed to get field" (avro_value_get_by_index !@value_ptr (Size_t.of_int 3) field_ptr (from_voidp string null));
    check_error "Failed to add element" (avro_value_append !@field_ptr element_ptr (from_voidp size_t null)); 
    check_error "Failed to set double"  (avro_value_set_double !@element_ptr 10.0);

    check_error "Failed to get field" (avro_value_get_by_index !@value_ptr (Size_t.of_int 4) field_ptr (from_voidp string null));
    check_error "Failed to get field" (avro_value_get_by_index !@field_ptr (Size_t.of_int 0) subfield_ptr (from_voidp string null));
    check_error "Failed to set float"  (avro_value_set_float !@subfield_ptr 5.0);

    check_error "Failed to set float"  (avro_value_get_by_index !@field_ptr (Size_t.of_int 1) subfield_ptr (from_voidp string null));
    check_error "Failed to set float"  (avro_value_set_long !@subfield_ptr (Int64.of_int 10000));


    check_error "Failed to set field"  (avro_value_get_by_index !@value_ptr (Size_t.of_int 5) field_ptr (from_voidp string null));
    check_error "Cannot select null branch" (avro_value_set_branch !@field_ptr 0 branch_ptr);

    avro_value_decref value_ptr;
    avro_value_iface_decref record_class;
    ignore (avro_schema_decref !@record_schema_ptr)

let test_union _ =
    let union_schema_ptr = allocate avro_schema_t null in
    let schema_str = "[" ^
    "  \"null\"," ^
    "  \"int\"," ^
    "  \"double\"," ^
    "  \"bytes\"" ^
    "]" in
    check_error "Failed to read avro schema" (avro_schema_from_json_literal schema_str union_schema_ptr);
    let union_class = avro_generic_class_from_schema !@union_schema_ptr in 
    let value_ptr = allocate_n avro_value ~count:1 in
    let discriminant_ptr = allocate_n int ~count:1 in
    check_error "Failed to create union" (avro_generic_value_new union_class value_ptr);
    check_error "Failed to get discriminant" (avro_value_get_discriminant !@value_ptr discriminant_ptr);
    assert_equal (-1) !@discriminant_ptr;
    let branch_ptr = allocate_n avro_value ~count:1 in
    assert_equal 0 (avro_value_get_current_branch !@value_ptr branch_ptr);
    check_error "Failed to get discriminant" (avro_value_set_branch !@value_ptr 0 branch_ptr);
    check_error "Failed to set branch" (avro_value_set_null !@branch_ptr);
    
    check_error "Failed to get discriminant" (avro_value_set_branch !@value_ptr 1 branch_ptr);
    check_error "Failed to set int"  (avro_value_set_int !@branch_ptr (Int32.of_int 10000));

    check_error "Failed to get discriminant" (avro_value_set_branch !@value_ptr 1 branch_ptr);
    check_error "Failed to set int"  (avro_value_set_int !@branch_ptr (Int32.of_int 10));

    check_error "Failed to get discriminant" (avro_value_set_branch !@value_ptr 2 branch_ptr);
    check_error "Failed to set double"  (avro_value_set_double !@branch_ptr 10.0);

    let bytes = allocate_n char ~count:4 in
    (bytes +@ 0) <-@ 'a';
    (bytes +@ 1) <-@ 'b';
    (bytes +@ 2) <-@ 'c';
    (bytes +@ 3) <-@ 'd';
    check_error "Failed to set branch" (avro_value_set_branch !@value_ptr 3 branch_ptr);
    check_error "Failed to set bytes"  (avro_value_set_bytes !@branch_ptr (to_voidp bytes) (Size_t.of_int 4));
    ignore (avro_value_decref value_ptr);
    ignore (avro_schema_decref !@union_schema_ptr);
    ignore (avro_value_iface_decref union_class)


let suit = "First Test" >:::
[
  "test_boolean" >:: test_boolean;
  "test_double" >:: test_double;
  "test_float" >:: test_float;
  "test_int" >:: test_int;
  "test_long" >:: test_long;
  "test_string" >:: test_string;
  "test_array" >:: test_array;
  "test_enum" >:: test_enum;
  "test_fixed" >:: test_fixed;
  "test_map" >:: test_map;
  "test_record" >:: test_record
]

let _ = run_test_tt_main suit
