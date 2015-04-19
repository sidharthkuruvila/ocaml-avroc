open Ctypes
open Foreign

open Schema
open Value
       
type avro_reader_t = unit ptr
let avro_reader_t : avro_reader_t typ = ptr void

type avro_writer_t = unit ptr
let avro_writer_t : avro_writer_t typ = ptr void

type file = unit ptr
let file : file typ = ptr void
                                      
let avro_reader_file =
      foreign "avro_reader_file" (file @-> returning avro_reader_t)

let avro_reader_file_fp =
  foreign "avro_reader_file_fp" (file @-> int @-> returning avro_reader_t)

let avro_writer_file =
  foreign "avro_writer_file" (file @-> returning avro_writer_t)

let avro_writer_file_fp =
  foreign "avro_writer_file_fp"
          (file @-> int @-> returning avro_writer_t)

let avro_reader_memory =
  foreign "avro_reader_memory" (string @-> int64_t @-> returning avro_reader_t)

let avro_writer_memory =
  foreign "avro_writer_memory" (string @-> int64_t @-> returning avro_writer_t )


let avro_reader_memory_set_source =
  foreign "avro_reader_memory_set_source"
          (avro_reader_t @-> string @-> returning int64_t)

let avro_writer_memory_set_dest =
  foreign "avro_writer_memory_set_dest"
          (avro_writer_t @-> string @-> returning int64_t)

          
let avro_read =
  foreign "avro_read" (avro_reader_t @-> ptr void @-> int64_t @-> returning int)

let avro_skip =
  foreign "avro_skip" (avro_reader_t @-> int64_t @-> returning int)

let avro_write =
  foreign "avro_write" (avro_writer_t @-> ptr void @->int64_t @-> returning int)

          
let avro_reader_reset =
  foreign "avro_reader_reset" (void @-> returning avro_reader_t)


let avro_writer_reset =
  foreign "avro_writer_reset"(avro_writer_t @-> returning void)
          
let avro_writer_tell =
  foreign "avro_writer_tell" (avro_writer_t @-> returning int64_t)

let avro_writer_flush =
  foreign "avro_writer_flush" (avro_writer_t @-> returning void)

          
let avro_writer_dump =
  foreign "avro_writer_dump" (avro_writer_t @-> file @-> returning void)
          
let avro_reader_dump =
  foreign "avro_reader_dump" (avro_reader_t @-> file @-> returning void)

let avro_reader_is_eof =
  foreign "avro_reader_is_eof" (avro_reader_t @-> returning int)

let avro_reader_free =
  foreign "avro_reader_free" (avro_reader_t @-> returning void)

let avro_writer_free =
  foreign "avro_writer_free" (avro_writer_t @-> returning void)

          
let avro_schema_to_json =
  foreign "avro_schema_to_json"
          (avro_schema_t @-> avro_writer_t @-> returning int)


let avro_value_read =
  foreign "avro_value_read"
          (avro_reader_t @-> ptr avro_value_t @-> returning int)

let avro_value_write =
  foreign "avro_value_write"
          (avro_writer_t @-> ptr avro_value_t @-> returning int)

let avro_value_sizeof =
  foreign "avro_value_sizeof"
          (ptr avro_value_t @-> ptr size_t @-> returning int)

type avro_file_reader_t = unit ptr
let avro_file_reader_t : avro_file_reader_t typ = ptr void

type avro_file_writer_t = unit ptr
let avro_file_writer_t : avro_file_writer_t typ = ptr void

let avro_file_writer_create =
  foreign "avro_file_writer_create"
          (string @-> avro_schema_t @->
	     ptr avro_file_writer_t @-> returning int)
let  avro_file_writer_create_fp =
  foreign "avro_file_writer_create_fp"
          (file @-> string @-> int @-> avro_schema_t @->
             ptr avro_file_writer_t @-> returning int)

let avro_file_writer_create_with_codec =
  foreign "avro_file_writer_create_with_codec"
          (string @->avro_schema_t @-> ptr avro_file_writer_t @->
             string @-> size_t @-> returning int)

let avro_file_writer_create_with_codec_fp =
  foreign "avro_file_writer_create_with_codec_fp"
          (file @-> string @-> int @-> avro_schema_t @->
             ptr avro_file_writer_t @-> string @-> size_t @-> returning int)
          
let avro_file_writer_open =
  foreign "avro_file_writer_open"
          (string @-> ptr avro_file_writer_t  @-> returning int)

let avro_file_writer_open_bs =
  foreign "avro_file_writer_open_bs"
          (string @-> ptr avro_file_writer_t @-> size_t @-> returning int)


let avro_file_reader =
  foreign "avro_file_reader"
          (string @-> ptr avro_file_reader_t @-> returning int)
let avro_file_reader_fp =
  foreign "avro_file_reader_fp"
          (file @-> string @-> int @-> ptr avro_file_reader_t @-> returning int)

let avro_file_reader_get_writer_schema =
  foreign "avro_file_reader_get_writer_schema"
          (avro_file_reader_t @-> returning avro_schema_t)

let avro_file_writer_sync =
  foreign "avro_file_writer_sync"
          (avro_file_writer_t @-> returning int)

let avro_file_writer_flush =
  foreign "avro_file_writer_flush"
          (avro_file_writer_t @-> returning int)

let avro_file_writer_close =
  foreign "avro_file_writer_close"
          (avro_file_writer_t @-> returning int)


let avro_file_reader_close =
  foreign "avro_file_reader_close"
          (avro_file_reader_t @-> returning int)


let avro_file_reader_read_value =
  foreign "avro_file_reader_read_value"
          (avro_file_reader_t @-> ptr avro_value_t @-> returning int)

  
let avro_file_writer_append_value =
  foreign "avro_file_writer_append_value"
          (avro_file_writer_t @-> ptr avro_value_t @-> returning int)

let avro_file_writer_append_encoded =
  foreign "avro_file_writer_append_encoded"
          (avro_file_writer_t @-> ptr void @-> int64_t @-> returning int)

