open Ctypes
open Foreign
open Basics
open Schema
open Data

(*Declaration of avro_value struct*)

type avro_value
let avro_value : avro_value structure typ =
  structure "avro_value"
let avro_value_t = avro_value
       
(* Declaration of avro_value_iface struct*)
                                        
type avro_value_iface
let avro_value_iface : avro_value_iface structure typ =
  structure "avro_value_iface"
let avro_value_iface_t = avro_value_iface

(* Definition of avro_value fields *)
let avro_value_avro_value_iface_t =
  field avro_value "avro_value_iface_t" (ptr avro_value_iface_t)

let avro_value_self =
  field avro_value "self" (ptr void)
                   
(*Definition of avro_value_iface fields*)

let avro_value_iface_incref_iface
  = field avro_value_iface "incref_iface" 
          (funptr
             (ptr avro_value_iface @->
                returning (ptr avro_value_iface)))
          
let avro_value_iface_decref_iface =
  field avro_value_iface "decref_iface"
        (funptr (ptr avro_value_iface_t @-> returning void))

let avro_value_iface_incref =
  field avro_value_iface "incref"
        (funptr (ptr avro_value_t @-> returning void))

let avro_value_iface_decref =
  field avro_value_iface "decref"
        (funptr (ptr avro_value_t @-> returning void))

let avro_value_iface_reset =
  field avro_value_iface "reset"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> returning int))

let avro_value_iface_get_type =
  field avro_value_iface "get_type"
        (funptr
           (ptr avro_value_iface_t @-> ptr void @-> returning avro_type_t))

let avro_value_iface_get_schema =
  field avro_value_iface "get_schema"
        (funptr
           (ptr avro_value_iface_t @-> ptr void @-> returning avro_schema_t))

let avro_value_iface_get_boolean =
  field avro_value_iface "get_boolean"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int @-> returning int))
        
let avro_value_iface_get_bytes =
  field avro_value_iface "get_bytes"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr string @-> ptr size_t @-> returning int))
        
let avro_value_iface_grab_bytes =
  field avro_value_iface "grab_bytes"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))
        
let avro_value_iface_get_double =
  field avro_value_iface "get_double"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr double @-> returning int))

let avro_value_iface_get_float =
  field avro_value_iface "get_float"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr float @-> returning int))
        
let avro_value_iface_get_int =
  field avro_value_iface "get_int"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int32_t @-> returning int))
            
let avro_value_iface_get_long =
  field avro_value_iface "get_long"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int64_t @-> returning int))

let avro_value_iface_get_null =
  field avro_value_iface "get_null"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> returning int))

let avro_value_iface_get_string =
  field avro_value_iface "get_string"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr string @-> ptr size_t @-> returning int))
        
let avro_value_iface_grab_string =
  field avro_value_iface "grab_string"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))

let avro_value_iface_get_enum =
  field avro_value_iface "get_enum"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int @-> returning int))

let avro_value_iface_get_fixed =
  field avro_value_iface "get_fixed"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr string @-> ptr size_t @-> returning int))

let avro_value_iface_grab_fixed =
  field avro_value_iface "grab_fixed"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))



let avro_value_iface_set_boolean =
  field avro_value_iface "set_boolean"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int @-> returning int))

let avro_value_iface_set_bytes =
  field avro_value_iface "set_bytes"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr void @-> ptr size_t @-> returning int))

let avro_value_iface_give_bytes =
  field avro_value_iface "give_bytes"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))

let avro_value_iface_set_double =
  field avro_value_iface "set_double"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr double @-> returning int))

let avro_value_iface_set_float =
  field avro_value_iface "set_float"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr float @-> returning int))

let avro_value_iface_set_int =
  field avro_value_iface "set_int"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int32_t @-> returning int))

let avro_value_iface_set_long =
  field avro_value_iface "set_long"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int64_t @-> returning int))

let avro_value_iface_set_null =
  field avro_value_iface "set_null"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> returning int))

let avro_value_iface_set_string =
  field avro_value_iface "set_string"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> string @-> returning int))

let avro_value_iface_set_string_len =
  field avro_value_iface "set_string_len"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> string @-> ptr size_t @-> returning int))

let avro_value_iface_give_string_len =
  field avro_value_iface "give_string_len"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))

let avro_value_iface_set_enum =
  field avro_value_iface "set_enum"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int @-> returning int))

let avro_value_iface_set_fixed =
  field avro_value_iface "set_fixed"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr void @-> ptr size_t @-> returning int))

let avro_value_iface_give_fixed =
  field avro_value_iface "give_fixed"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))

let avro_value_iface_get_size =
  field avro_value_iface "get_size"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr size_t @-> returning int))

let avro_value_iface_get_by_index =
  field avro_value_iface "get_by_index"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr size_t @-> ptr avro_value_t @-> ptr string @-> returning int))

let avro_value_iface_get_by_name =
  field avro_value_iface "get_by_name"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> string @-> ptr avro_value_t @-> ptr size_t @-> returning int))

let avro_value_iface_get_discriminant =
  field avro_value_iface "get_discriminant"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int @-> returning int))

let avro_value_iface_get_current_branch =
  field avro_value_iface "get_current_branch"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_value_t @-> returning int))

let avro_value_iface_append =
  field avro_value_iface "append"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_value_t @-> ptr size_t @-> returning int))

let avro_value_iface_add =
  field avro_value_iface "add"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> string @-> ptr avro_value_t @-> ptr size_t @-> ptr int @-> returning int))

let avro_value_iface_set_branch =
  field avro_value_iface "set_branch"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int @-> ptr avro_value_t @-> returning int))

  
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
