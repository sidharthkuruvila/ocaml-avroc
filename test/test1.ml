open OUnit2

let suit = "First Test" >:::
[
  "test" >:: (fun test_ctxt -> print_string "Hello";assert_equal true false)
]

let _ = run_test_tt_main suit
