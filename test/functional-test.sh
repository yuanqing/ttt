#!/usr/bin/env roundup

describe "ttt: functional tests"

ttt() {
  ../../../ttt "$@" 2>&1
}

it_works_with_default_settings() {
  cd fixtures/default
  ttt cat | cmp ../default.txt
  rm -rf actual
}

it_works_with_custom_settings() {
  cd fixtures/custom
  ttt -i in -o out -I .in -O .out -- cat | cmp ../custom.txt
  rm -rf actual
}
