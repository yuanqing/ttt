#!/usr/bin/env roundup

describe "ttt"

alias ttt="../ttt"

__fail() {

  # check that exit code is non-zero
  [ "$?" -ne 0 ]

  # check that output ($1) starts with the error message ($2)
  case $1 in
    "../ttt: $2"* ) true;;
    * ) false;;
  esac

}

before() {
  rm -rf input output actual
}

it_fails_if_no_run_command_specified() {
  local msg="need a run command"
  __fail "$(ttt 2>&1)" "$msg"
  __fail "$(ttt -- 2>&1)" "$msg"
  __fail "$(ttt -s 2>&1)" "$msg"
  __fail "$(ttt -s -- 2>&1)" "$msg"
}

it_fails_if_option_specified_without_a_value() {
  local msg="option expects a value"
  __fail "$(ttt -i 2>&1)" "-i: $msg"
  __fail "$(ttt -i -o 2>&1)" "-i: $msg"
  __fail "$(ttt -i -o 2>&1)" "-i: $msg"
  __fail "$(ttt -i foo -o 2>&1)" "-o: $msg"
  __fail "$(ttt -i foo -o -- 2>&1)" "-o: $msg"
}

it_fails_if_input_dir_does_not_exist() {
  local msg="input: no such input directory"
  __fail "$(ttt -- echo 2>&1)" "$msg"
}

it_fails_if_output_dir_does_not_exist() {
  mkdir -p input
  local msg="output: no such output directory"
  __fail "$(ttt -- echo 2>&1)" "$msg"
}

it_fails_if_no_input_files() {
  mkdir -p input output
  local msg="input: no input files found"
  __fail "$(ttt -- echo 2>&1)" "$msg"
}

after() {
  rm -rf input output actual
}
