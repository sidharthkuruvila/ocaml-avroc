open Ctypes
open Foreign

type avro_value_t = unit
let avro_value_t : avro_value_t typ = void


let avro_value_incref =
  foreign "avro_value_incref" (ptr avro_value_t @-> returning void)

let avro_value_decref =
  foreign "avro_value_incref" (ptr avro_value_t @-> returning void)

let avro_value_copy_ref =
  foreign "avro_value_copy_ref"
      (ptr avro_value_t @-> ptr avro_value_t @-> returning void)

let avro_value_move_ref =
  foreign "avro_value_move_ref"
      (ptr avro_value_t @-> ptr avro_value_t @-> returning void)

let avro_value_equal =
  foreign "avro_value_equal"
      (ptr avro_value_t @-> ptr avro_value_t @-> returning int)

let avro_value_equal_fast =
  foreign "avro_value_equal_fast"
      (ptr avro_value_t @-> ptr avro_value_t @-> returning int)

let avro_value_cmp =
  foreign "avro_value_cmp"
      (ptr avro_value_t @-> ptr avro_value_t @-> returning int)

let avro_value_cmp_fast =
  foreign "avro_value_cmp_fast"
      (ptr avro_value_t @-> ptr avro_value_t @-> returning int)

let avro_value_copy =
  foreign "avro_value_copy"
      (ptr avro_value_t @-> ptr avro_value_t @-> returning int)

let avro_value_copy_fast =
  foreign "avro_value_copy_fast"
      (ptr avro_value_t @-> ptr avro_value_t @-> returning int)

let avro_value_hash =
  foreign "avro_value_hash"
    (ptr avro_value_t @-> returning uint32_t)

let avro_value_to_json =
  foreign "avro_value_to_json"
    (ptr avro_value_t @-> int @-> ptr string @-> returning int)
