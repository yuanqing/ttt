#!/usr/bin/env roundup

describe "ttt: functional tests"

ttt() {
  ../../../ttt "$@" 2>&1
}

__exit_0() {
  [ "$?" -eq 0 ]
}

__exit_1() {
  [ "$?" -eq 1 ]
}

it_works_on_default_settings_with_no_failing_tests() {
  cd fixtures/default-passing
  ttt cat | cmp ../default-passing.txt
  __exit_0 "$(ttt cat)"
  rm -rf actual
}

it_works_on_default_settings_with_some_failing_tests() {
  cd fixtures/default-failing
  ttt cat | cmp ../default-failing.txt
  __exit_1 "$(ttt cat)"
  rm -rf actual
}

it_works_on_custom_settings_with_no_failing_tests() {
  cd fixtures/custom-passing
  ttt -i in -o out -I .in -O .out -- cat | cmp ../custom-passing.txt
  __exit_0 "$(ttt -i in -o out -I .in -O .out -- cat)"
  rm -rf actual
}

it_works_on_custom_settings_with_some_failing_tests() {
  cd fixtures/custom-failing
  ttt -i in -o out -I .in -O .out -- cat | cmp ../custom-failing.txt
  __exit_1 "$(ttt -i in -o out -I .in -O .out -- cat)"
  rm -rf actual
}
