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
    opam install ctypes-foreign


### Running tests

    make test_values

### Running the quickstop example

    
    make quickstop
