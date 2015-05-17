function test(){
	corebuild -r -I src -lflags -cclib,-lavro,-cclib,-L/usr/local/Cellar/avro-c/1.7.7/lib -pkg ctypes.foreign test/$1.native \
	&& ./$1.native || { echo "Test $1 failed" ; rm $1.native; exit 1; }
	rm $1.native
}


#test test1
test test_values
rm -r _build


