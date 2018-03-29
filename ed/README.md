# ed

This package provides the GNU ed binary.

[GNU Ed](https://www.gnu.org/software/ed/) is a line-oriented editor.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

[binary wrapper package](https://www.habitat.sh/docs/best-practices/#binary-wrapper-packages)

## Usage

```
$ hab pkg install core/ed
$ hab pkg binlink core/ed
$ ed --help
GNU Ed - The GNU line editor.

Usage: ed [options] [file]

Options:
  -h, --help                 display this help and exit
  -V, --version              output version information and exit
  -G, --traditional          run in compatibility mode
  -l, --loose-exit-status    exit with 0 status even if a command fails
  -p, --prompt=STRING        use STRING as an interactive prompt
  -r, --restricted           run in restricted mode
  -s, --quiet, --silent      suppress diagnostics, byte counts and '!' prompt
  -v, --verbose              be verbose; equivalent to the 'H' command
Start edit by reading in 'file' if given.
If 'file' begins with a '!', read output of shell command.

Exit status: 0 for a normal exit, 1 for environmental problems (file
not found, invalid flags, I/O errors, etc), 2 to indicate a corrupt or
invalid input file, 3 for an internal consistency error (eg, bug) which
caused ed to panic.

Report bugs to bug-ed@gnu.org
Ed home page: http://www.gnu.org/software/ed/ed.html
General help using GNU software: http://www.gnu.org/gethelp
```
