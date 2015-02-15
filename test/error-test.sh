#!/usr/bin/env roundup

describe "ttt: error tests"

ttt() {
  ../ttt "$@" 2>&1
}

__error() {

  # check that exit code is 1
  [ "$?" -eq 1 ]

  # check that output ($1) ends with the error message ($2)
  case "$1" in
    "../ttt: $2"* ) true;;
    * ) false;;
  esac

}

it_errors_if_no_run_command_specified() {
  local msg="need a run command"
  __error "$(ttt)" "$msg"
  __error "$(ttt --)" "$msg"
  __error "$(ttt -i foo)" "$msg"
  __error "$(ttt -i foo --)" "$msg"
}

it_errors_if_option_specified_without_a_value() {
  local msg="option expects a value"
  __error "$(ttt -i)" "-i: $msg"
  __error "$(ttt -i -o)" "-i: $msg"
  __error "$(ttt -i -o)" "-i: $msg"
  __error "$(ttt -i foo -o)" "-o: $msg"
  __error "$(ttt -i foo -o --)" "-o: $msg"
}

it_errors_if_input_dir_does_not_exist() {
  local msg="input: no such input directory"
  __error "$(ttt echo)" "$msg"
}

it_errors_if_output_dir_does_not_exist() {
  mkdir -p input
  local msg="output: no such output directory"
  __error "$(ttt echo)" "$msg"
  rm -rf input
}

it_errors_if_no_input_files() {
  mkdir -p input output
  local msg="input: no input files found"
  __error "$(ttt echo)" "$msg"
  rm -rf input output actual
}
