
#ocamlbuild -r -I src  -pkg ctypes.foreign examples/quickstop.native
corebuild -r -I src  -lflags -cclib,-lavro,-cclib,-L/usr/local/Cellar/avro-c/1.7.7/lib -pkg ctypes.foreign examples/quickstop.native