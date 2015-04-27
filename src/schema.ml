open Ctypes
open Foreign

type avro_schema_t = unit ptr
let avro_schema_t : avro_schema_t typ = ptr void


let  avro_schema_string =
  foreign "avro_schema_string" (void @-> returning avro_schema_t)

let  avro_schema_bytes =
  foreign "avro_schema_bytes" (void @-> returning avro_schema_t)

let  avro_schema_int =
  foreign "avro_schema_int" (void @-> returning avro_schema_t)

let  avro_schema_long =
  foreign "avro_schema_long" (void @-> returning avro_schema_t)

let  avro_schema_float =
  foreign "avro_schema_float" (void @-> returning avro_schema_t)

let  avro_schema_double =
  foreign "avro_schema_double" (void @-> returning avro_schema_t)

let  avro_schema_boolean =
  foreign "avro_schema_boolean" (void @-> returning avro_schema_t)

let  avro_schema_null =
  foreign "avro_schema_null" (void @-> returning avro_schema_t)

let avro_schema_record =
  foreign "avro_schema_record" (string @-> string @-> returning avro_schema_t)

let avro_schema_record_field_get =
  foreign "avro_schema_record_field_get"
      (avro_schema_t @-> string @-> returning avro_schema_t)

let avro_schema_record_field_name =
  foreign "avro_schema_record_field_name"
      (avro_schema_t @-> int @-> returning string)

let avro_schema_record_field_get_index =
  foreign "avro_schema_record_field_get_index"
          (avro_schema_t @-> string @-> returning int)

let avro_schema_record_field_get_by_index =
  foreign "avro_schema_record_field_get_by_index"
          (avro_schema_t @-> int @-> returning avro_schema_t)

let avro_schema_record_field_append =
  foreign "avro_schema_record_field_append"
          (avro_schema_t @-> string @-> avro_schema_t @-> returning int)

let avro_schema_record_size =
  foreign "avro_schema_record_size" (avro_schema_t @-> returning size_t)


let avro_schema_enum =
  foreign "avro_schema_enum" (string @-> returning avro_schema_t)

let avro_schema_enum_get =
  foreign "avro_schema_enum_get" (avro_schema_t @-> int @-> returning string)

let avro_schema_enum_get_by_name =
  foreign "avro_schema_enum_get_by_name"
          (avro_schema_t @-> string @-> returning int)

let avro_schema_enum_symbol_append =
  foreign "avro_schema_enum_symbol_append"
          (avro_schema_t @-> string @-> returning int)


let avro_schema_fixed =
  foreign "avro_schema_fixed" (string @-> int64_t @-> returning avro_schema_t)

let avro_schema_fixed_size =
  foreign "avro_schema_fixed_size" (avro_schema_t @-> returning int64_t)


let avro_schema_map =
  foreign "avro_schema_map" (avro_schema_t @-> returning avro_schema_t)

let avro_schema_map_values =
  foreign "avro_schema_map_values" (avro_schema_t @-> returning avro_schema_t)


let avro_schema_array =
  foreign "avro_schema_array" (avro_schema_t @-> returning avro_schema_t)

let avro_schema_array_items =
  foreign "avro_schema_array_items" (avro_schema_t @-> returning avro_schema_t)


let avro_schema_union =
  foreign "avro_schema_union" (void @-> returning avro_schema_t)

let avro_schema_union_size =
  foreign "avro_schema_union_size" (avro_schema_t @-> returning size_t)

let avro_schema_union_append =
  foreign "avro_schema_union_append"
          (avro_schema_t @-> avro_schema_t @-> returning int)

let avro_schema_union_branch =
  foreign "avro_schema_union_branch"
          (avro_schema_t @-> int @-> returning avro_schema_t)

let avro_schema_union_branch_by_name =
  foreign "avro_schema_union_branch_by_name"
          (avro_schema_t @-> ptr int @-> string @-> returning avro_schema_t)


let  avro_schema_link =
  foreign "avro_schema_link" (avro_schema_t @-> returning avro_schema_t)

let avro_schema_link_target =
  foreign "avro_schema_link_target" (avro_schema_t @-> returning avro_schema_t)

type avro_schema_error_t = unit ptr
let avro_schema_error_t : avro_schema_error_t typ = ptr void

let avro_schema_from_json =
  foreign "avro_schema_from_json"
          (string @-> int32_t @-> avro_schema_t @-> returning avro_schema_error_t)

let avro_schema_from_json_length =
  foreign "avro_schema_from_json_length"
    (string @-> size_t @-> ptr avro_schema_t @-> returning int)

let avro_schema_from_json_literal schema_str schema =
  avro_schema_from_json_length
    schema_str (Unsigned.Size_t.of_int (String.length schema_str)) schema

(*
Not present in the dynamic libarary file
let avro_schema_to_specific =
  foreign "avro_schema_to_specific"(avro_schema_t @-> string @-> returning int)
 *)

let avro_schema_get_subschema =
  foreign "avro_schema_get_subschema"
          (avro_schema_t @-> string @-> returning avro_schema_t)

let avro_schema_name =
  foreign "avro_schema_name" (avro_schema_t @-> returning string)

let avro_schema_type_name =
    foreign "avro_schema_type_name" (avro_schema_t @-> returning string)

let avro_schema_copy =
  foreign "avro_schema_copy" (avro_schema_t @-> returning avro_schema_t)

let avro_schema_equal =
  foreign "avro_schema_equal"
          (avro_schema_t @-> avro_schema_t @-> returning int)


let avro_schema_match =
  foreign "avro_schema_match"
          (avro_schema_t @-> avro_schema_t @-> returning int)
