# ttt [![Version](https://img.shields.io/badge/version-v0.1.1-orange.svg?style=flat)](https://github.com/yuanqing/ttt/releases) [![Build Status](https://img.shields.io/travis/yuanqing/ttt.svg?branch=master&style=flat)](https://travis-ci.org/yuanqing/ttt)

> A [TAP](http://testanything.org/)-compliant Bash utility for testing programs that read from `stdin` and write to&nbsp;`stdout`.

## Usage

To test [a program](https://github.com/yuanqing/ttt/tree/master/example/hello.c) with `ttt`, we will need:

1. A directory of input files.
2. A directory of corresponding expected output files.

```
$ ls
hello.c   input     output
$ ls input
bar       baz       qux
$ ls output
bar       baz       qux
```

In our [toy example](https://github.com/yuanqing/ttt/tree/master/example), there are three tests. Each test works like so:

1. The input file is fed to the program via `stdin`.
2. The actual output (via `stdout`) is compared with the expected output file; the test passes if and only if the two are *exactly the same*.

To run the tests, simply do:

```
$ gcc hello.c && ttt -- ./a.out
TAP version 13
1..3
ok 1 - bar
not ok 2 - baz
  ---
  error: 'output/baz actual/baz differ: byte 7, line 1'
  ...
ok 3 - qux
# tests 3
# pass  2
# fail  1
```

Note that `ttt` exits with code `0` if and only if every test passes. Because the second test failed, `ttt` exits with code `1`:

```
$ echo $?
1
```

For debugging, the program&rsquo;s actual output is stored in a directory named `actual`:

```
$ ls
a.out     actual    hello.c   input     output
$ ls actual
bar       baz       qux
```

## CLI

```
Usage: ttt [options] -- run_cmd
  run_cmd: The command to invoke the program under test.
  options:
    -i INPUT_DIR   Path to the directory containing the input files.
                   Default: './input'.
    -o OUTPUT_DIR  Path to the directory containing the expected output
                   files. Default: './output'.
    -a ACTUAL_DIR  Path to the directory to write your program's output.
                   Default: './actual'.
    -I IN_EXT      The file extension of the input files.
    -O OUT_EXT     The file extension of the expected output files.
```

## Tests

Run the [Roundup](https://github.com/bmizerany/roundup) tests like so:

```
$ cd test
$ bash vendor/roundup.sh
```

## Installation

To install `ttt` into `/usr/local/bin`, simply do:

```
$ curl -L https://raw.github.com/yuanqing/ttt/master/ttt -o /usr/local/bin/ttt
$ chmod +x /usr/local/bin/ttt
```

## Changelog

- 0.1.0
  - Initial release

## License

[MIT](https://github.com/yuanqing/ttt/blob/master/LICENSE)
