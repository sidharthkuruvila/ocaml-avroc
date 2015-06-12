all:

quickstop: 
	ocamlbuild quickstop.native

avroc: avroc.cma avroc.cmxa

avroc.cmxa:
	ocamlbuild avroc.cmxa

avroc.cma:
	ocamlbuild avroc.cma

test_%: test_%.native
	./$<

test_%.native:
	ocamlbuild $@

.PHONEY: clean quickstop avroc
clean:
	ocamlbuild -clean