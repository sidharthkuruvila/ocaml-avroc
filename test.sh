function test(){
	corebuild -r -I src -lflags -cclib,-lavro,-cclib,-L/usr/local/Cellar/avro-c/1.7.7/lib -pkg ctypes.foreign test/$1.native && ./$1.native || { echo "Test $1 failed" ; exit 1; }
}


test test1


