VPATH = src:test:examples:_build


all:

quickstop: quickstop.native
	./quickstop.native

quickstop.native: _build/libavro.a
	ocamlbuild quickstop.native

avroc: avroc.cma avroc.cmxa avroc.cmxs

avroc.cmxa: _build/libavro.a
	ocamlbuild avroc.cmxa

avroc.cma: _build/libavro.a
	ocamlbuild avroc.cma

avroc.cmxs: _build/libavro.a
	ocamlbuild avroc.cmxs

test_%: test_%.native
	./$<

test_%.native: _build/libavro.a
	ocamlbuild $@

install: avroc
	./install.sh

uninstall:
	ocamlfind remove avroc

.PHONEY: clean quickstop avroc install
clean:
	ocamlbuild -clean


avro-c-dir:
	mkdir avro-c-dir

avro-c-dir/avro-c-1.7.7.tar.gz: avro-c-dir
	./scripts/download_avroc.sh

avro-c-dir/avro-c-1.7.7: avro-c-dir/avro-c-1.7.7.tar.gz
	tar xzf avro-c-dir/avro-c-1.7.7.tar.gz -C avro-c-dir

avro-c-dir/avro-c-1.7.7/build: avro-c-dir/avro-c-1.7.7
	cd avro-c-dir/avro-c-1.7.7; ./cmake_avrolib.sh

_build/libavro.a: avro-c-dir/avro-c-1.7.7/build _build
	cp avro-c-dir/avro-c-1.7.7/build/avrolib/lib/libavro* _build/

_build:
	mkdir _build




