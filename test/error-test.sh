#!/usr/bin/env roundup

describe "ttt: erroring tests"

ttt() {
  ../ttt "$@" 2>&1
}

__errors() {

  # check that exit code is 1
  [ "$?" -eq 1 ]

  # check that output ($1) ends with the error message ($2)
  case $1 in
    "../ttt: $2"* ) true;;
    * ) false;;
  esac

}

it_errors_if_no_run_command_specified() {
  local msg="need a run command"
  __errors "$(ttt)" "$msg"
  __errors "$(ttt --)" "$msg"
  __errors "$(ttt -s)" "$msg"
  __errors "$(ttt -s --)" "$msg"
}

it_errors_if_option_specified_without_a_value() {
  local msg="option expects a value"
  __errors "$(ttt -i)" "-i: $msg"
  __errors "$(ttt -i -o)" "-i: $msg"
  __errors "$(ttt -i -o)" "-i: $msg"
  __errors "$(ttt -i foo -o)" "-o: $msg"
  __errors "$(ttt -i foo -o --)" "-o: $msg"
}

it_errors_if_input_dir_does_not_exist() {
  local msg="input: no such input directory"
  __errors "$(ttt echo)" "$msg"
}

it_errors_if_output_dir_does_not_exist() {
  mkdir -p input
  local msg="output: no such output directory"
  __errors "$(ttt echo)" "$msg"
  rm -rf input
}

it_errors_if_no_input_files() {
  mkdir -p input output
  local msg="input: no input files found"
  __errors "$(ttt echo)" "$msg"
  rm -rf input output actual
}
