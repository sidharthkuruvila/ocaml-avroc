CURRENT_DIR=`pwd`
LINKER_FLAGS=-cclib,-l,-cclib,avro.22.0.0,-cclib,-L,-cclib,${CURRENT_DIR}/lib
corebuild -r -I src -lflags $LINKER_FLAGS -pkg ctypes.foreign examples/quickstop.native