all:

quickstop: quickstop.native
	./quickstop.native

quickstop.native: 
	ocamlbuild quickstop.native

avroc: avroc.cma avroc.cmxa avroc.cmxs

avroc.cmxa:
	ocamlbuild avroc.cmxa

avroc.cma:
	ocamlbuild avroc.cma

avroc.cmxs:
	ocamlbuild avroc.cmxs

test_%: test_%.native
	./$<

test_%.native:
	ocamlbuild $@

install: avroc.cma avroc.cxma


.PHONEY: clean quickstop avroc
clean:
	ocamlbuild -clean