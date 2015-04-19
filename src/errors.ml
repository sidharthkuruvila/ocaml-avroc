open Ctypes
open Foreign

let  avro_strerror =
  foreign "avro_strerror" (void @-> returning string)
