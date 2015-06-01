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
                   
let () = seal avro_value
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
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr (ptr char) @-> ptr size_t @-> returning int))
        
let avro_value_iface_grab_string =
  field avro_value_iface "grab_string"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))

let avro_value_iface_get_enum =
  field avro_value_iface "get_enum"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr int @-> returning int))

let avro_value_iface_get_fixed =
  field avro_value_iface "get_fixed"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr (ptr void) @-> ptr size_t @-> returning int))

let avro_value_iface_grab_fixed =
  field avro_value_iface "grab_fixed"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))



let avro_value_iface_set_boolean =
  field avro_value_iface "set_boolean"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> int @-> returning int))

let avro_value_iface_set_bytes =
  field avro_value_iface "set_bytes"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr void @-> size_t @-> returning int))

let avro_value_iface_give_bytes =
  field avro_value_iface "give_bytes"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))

let avro_value_iface_set_double =
  field avro_value_iface "set_double"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> double @-> returning int))

let avro_value_iface_set_float =
  field avro_value_iface "set_float"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> float @-> returning int))

let avro_value_iface_set_int =
  field avro_value_iface "set_int"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> int32_t @-> returning int))

let avro_value_iface_set_long =
  field avro_value_iface "set_long"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> int64_t @-> returning int))

let avro_value_iface_set_null =
  field avro_value_iface "set_null"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> returning int))

let avro_value_iface_set_string =
  field avro_value_iface "set_string"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> string @-> returning int))

let avro_value_iface_set_string_len =
  field avro_value_iface "set_string_len"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> string @-> size_t @-> returning int))

let avro_value_iface_give_string_len =
  field avro_value_iface "give_string_len"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))

let avro_value_iface_set_enum =
  field avro_value_iface "set_enum"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> int @-> returning int))

let avro_value_iface_set_fixed =
  field avro_value_iface "set_fixed"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr void @-> size_t @-> returning int))

let avro_value_iface_give_fixed =
  field avro_value_iface "give_fixed"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr avro_wrapped_buffer_t @-> returning int))

let avro_value_iface_get_size =
  field avro_value_iface "get_size"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> ptr size_t @-> returning int))

let avro_value_iface_get_by_index =
  field avro_value_iface "get_by_index"
        (funptr (ptr avro_value_iface_t @-> ptr void @-> size_t @-> ptr avro_value_t @-> ptr string @-> returning int))

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

let () = seal avro_value_iface
  
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


(* Helper functions*)
let get_method value meth =
  let iface  = (getf value avro_value_avro_value_iface_t) in
  let self  = (getf value avro_value_self) in
  let m =  (getf !@iface  meth) in
  m iface self

let avro_value_iface_incref cls =
  let meth = getf !@cls avro_value_iface_decref_iface in
  meth cls

let avro_value_iface_decref cls =
  let meth = getf !@cls avro_value_iface_decref_iface in
  meth cls

       
let avro_value_reset value =
  get_method value avro_value_iface_reset

let avro_value_get_boolean value out =
  get_method value avro_value_iface_get_boolean out 
(*

#define avro_value_reset(value) \
    avro_value_call0(value, reset, EINVAL)
#define avro_value_get_type(value) \
    avro_value_call0(value, get_type, (avro_type_t) -1)
#define avro_value_get_schema(value) \
    avro_value_call0(value, get_schema, NULL)

#define avro_value_get_boolean(value, out) \
    avro_value_call(value, get_boolean, EINVAL, out)
#define avro_value_get_bytes(value, buf, size) \
    avro_value_call(value, get_bytes, EINVAL, buf, size)
#define avro_value_grab_bytes(value, dest) \
    avro_value_call(value, grab_bytes, EINVAL, dest)
  *)
(*
#define avro_value_get_double(value, out) \
    avro_value_call(value, get_double, EINVAL, out)
*)

let avro_value_get_double value out = 
  get_method value avro_value_iface_get_double out

(*
#define avro_value_get_float(value, out) \
    avro_value_call(value, get_float, EINVAL, out)
  *)
let avro_value_get_float value out = 
  get_method value avro_value_iface_get_float out

(*
#define avro_value_get_int(value, out) \
    avro_value_call(value, get_int, EINVAL, out)
*)
let avro_value_get_int value out = 
  get_method value avro_value_iface_get_int out

(*
#define avro_value_get_long(value, out) \
    avro_value_call(value, get_long, EINVAL, out)
  *)
let avro_value_get_long value out = 
  get_method value avro_value_iface_get_long out

(*
#define avro_value_get_null(value) \
    avro_value_call0(value, get_null, EINVAL)
  *)
(*
#define avro_value_get_string(value, str, size) \
    avro_value_call(value, get_string, EINVAL, str, size)
*)
let avro_value_get_string value out size = 
  get_method value avro_value_iface_get_string out size


(*
#define avro_value_grab_string(value, dest) \
    avro_value_call(value, grab_string, EINVAL, dest) *)

(*#define avro_value_get_enum(value, out) \
     avro_value_call(value, get_enum, EINVAL, out)*)
let avro_value_get_enum value out = 
  get_method value avro_value_iface_get_enum out

(*#define avro_value_get_fixed(value, buf, size) \
    avro_value_call(value, get_fixed, EINVAL, buf, size) *)
let avro_value_get_fixed value buf size = 
  get_method value avro_value_iface_get_fixed buf size

(*#define avro_value_grab_fixed(value, dest) \
    avro_value_call(value, grab_fixed, EINVAL, dest)
*)
(*#define avro_value_set_boolean(value, val) \
     avro_value_call(value, set_boolean, EINVAL, val)*)
let avro_value_set_boolean value out =
  get_method value avro_value_iface_set_boolean out
(*
#define avro_value_set_bytes(value, buf, size) \
    avro_value_call(value, set_bytes, EINVAL, buf, size)
#define avro_value_give_bytes(value, buf) \
    avro_value_call(value, give_bytes, EINVAL, buf)
*)

(*
#define avro_value_set_double(value, val) \
    avro_value_call(value, set_double, EINVAL, val)
*)
let avro_value_set_double value out =
  get_method value avro_value_iface_set_double out
    (*
#define avro_value_set_float(value, val) \
    avro_value_call(value, set_float, EINVAL, val)
  *)
let avro_value_set_float value out =
  get_method value avro_value_iface_set_float out
(*
#define avro_value_set_int(value, val) \
    avro_value_call(value, set_int, EINVAL, val)
*)
let avro_value_set_int value out =
  get_method value avro_value_iface_set_int out
(*
#define avro_value_set_long(value, val) \
    avro_value_call(value, set_long, EINVAL, val)
  *)
let avro_value_set_long value out =
  get_method value avro_value_iface_set_long out
(*
#define avro_value_set_null(value) \
    avro_value_call0(value, set_null, EINVAL)
*)
(*#define avro_value_set_string(value, str) \
    avro_value_call(value, set_string, EINVAL, str)*)
let avro_value_set_string value out =
  get_method value avro_value_iface_set_string out
(*
#define avro_value_set_string_len(value, str, size) \
    avro_value_call(value, set_string_len, EINVAL, str, size) *)
let avro_value_set_string_len value out size =
  get_method value avro_value_iface_set_string_len out size
(* #define avro_value_give_string_len(value, buf) \
    avro_value_call(value, give_string_len, EINVAL, buf) *)

(*#define avro_value_set_enum(value, val) \
    avro_value_call(value, set_enum, EINVAL, val)*)
let avro_value_set_enum value out =
  get_method value avro_value_iface_set_enum out


(*#define avro_value_set_fixed(value, buf, size) \
    avro_value_call(value, set_fixed, EINVAL, buf, size)*)

let  avro_value_set_fixed value buf size = 
  get_method value avro_value_iface_set_fixed buf size

(*
#define avro_value_give_fixed(value, buf) \
    avro_value_call(value, give_fixed, EINVAL, buf)*)

(*#define avro_value_get_size(value, size) \
    avro_value_call(value, get_size, EINVAL, size)*)
let avro_value_get_size value out =
  get_method value avro_value_iface_get_size out

(*#define avro_value_get_by_index(value, idx, child, name) \
    avro_value_call(value, get_by_index, EINVAL, idx, child, name) *)

let avro_value_get_by_index value idx child name =
  get_method value avro_value_iface_get_by_index idx child name

(*#define avro_value_get_by_name(value, name, child, index) \
    avro_value_call(value, get_by_name, EINVAL, name, child, index)
#define avro_value_get_discriminant(value, out) \
    avro_value_call(value, get_discriminant, EINVAL, out)
#define avro_value_get_current_branch(value, branch) \
    avro_value_call(value, get_current_branch, EINVAL, branch)
*)
(*#define avro_value_append(value, child, new_index) \
    avro_value_call(value, append, EINVAL, child, new_index)*)
let avro_value_append value child new_index =
  get_method value avro_value_iface_append child new_index

(*#define avro_value_add(value, key, child, index, is_new) \
    avro_value_call(value, add, EINVAL, key, child, index, is_new)
  *)
let avro_value_add value key child index is_new = 
  get_method value avro_value_iface_add key child index is_new

(*#define avro_value_set_branch(value, discriminant, branch) \
    avro_value_call(value, set_branch, EINVAL, discriminant, branch)
 *)
       

       
