open Schema
open Value
open Ctypes
open Foreign
       
let avro_generic_class_from_schema =
  foreign "avro_generic_class_from_schema"
          (avro_schema_t @-> returning (ptr avro_value_iface_t))


let avro_generic_value_new =
  foreign "avro_generic_value_new"
          (ptr avro_value_iface_t @-> ptr avro_value_t @-> returning int)

let avro_generic_boolean_class =
  foreign "avro_generic_boolean_class"
          (void @-> returning (ptr avro_value_iface_t))

let avro_generic_bytes_class =
  foreign "avro_generic_bytes_class"
          (void @-> returning (ptr avro_value_iface_t))
          
let avro_generic_double_class =
  foreign "avro_generic_double_class"
          (void @-> returning (ptr avro_value_iface_t))

let avro_generic_float_class =
  foreign "avro_generic_float_class"
          (void @-> returning (ptr avro_value_iface_t))

let avro_generic_int_class =
  foreign "avro_generic_int_class"
          (void @-> returning (ptr avro_value_iface_t))

let avro_generic_long_class =
  foreign "avro_generic_long_class"
          (void @-> returning (ptr avro_value_iface_t))
          
let avro_generic_null_class =
  foreign "avro_generic_null_class"
          (void @-> returning (ptr avro_value_iface_t))

let avro_generic_string_class =
  foreign "avro_generic_string_class"
          (void @-> returning (ptr avro_value_iface_t))








let avro_generic_boolean_new =
  foreign "avro_generic_boolean_new"
          (ptr avro_value_t @-> int @-> returning int)


let avro_generic_bytes_new =
  foreign "avro_generic_bytes_new"
          ((ptr avro_value_t) @-> string @-> size_t @-> returning int)

let avro_generic_double_new =
  foreign "avro_generic_double_new"
          (ptr avro_value_t @-> double @->returning int)
          
let avro_generic_float_new =
  foreign "avro_generic_float_new"
          (ptr avro_value_t @-> float @-> returning int)

let avro_generic_int_new =
  foreign "avro_generic_int_new"
          (ptr avro_value_t @-> int32_t @-> returning int)

let avro_generic_long_new =
  foreign "avro_generic_long_new"
          (ptr avro_value_t @-> int64_t @-> returning int)

let avro_generic_null_new =
  foreign "avro_generic_null_new"
          (ptr avro_value_t @-> returning int)

let avro_generic_string_new =
  foreign "avro_generic_string_new"
          (ptr avro_value_t @-> string @-> returning int)

let avro_generic_string_new_length =
  foreign "avro_generic_string_new_length"
          (ptr avro_value_t @-> string @-> size_t @-> returning int)
