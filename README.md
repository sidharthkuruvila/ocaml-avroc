Ocaml Avro C
============

This is a ocaml ctypes wrapper around the avro c library.



Building
--------

###Add dependencies

These currently only work on osx

Install avroc
  
    brew install avroc

Install ocam dependencies

    opam install ctypes
    opam install ounit


### Running tests

    ./test.sh

### Building quickstop example

    ./build.sh
    ./quickstop.native
