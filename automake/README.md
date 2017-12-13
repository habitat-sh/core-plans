# automake

This package provides `automake` the GNU tool to generate make files.

## Usage

Typically this is a build time dependency that can be added to your
plan.sh:

    pkg_build_deps=(core/automake)

## TODO

`make check` do not pass all tests, here are the ones that fail as of 2017-12-13:

* t/amopts-location.sh
* t/add-missing-install-sh.sh
* t/javadir-undefined.sh
* t/java-mix.sh
* t/lex-depend.sh
* t/location.sh
* t/preproc-errmsg.sh
* t/repeated-options.sh
* t/src-acsubst.sh
* t/vars3.sh
* t/warnopts.sh
* t/warnings-win-over-strictness.sh
* t/yflags-conditional.sh

Also, note that this test suite is designed with many compilers/interpreters in mind (eg: java, python)
making them all pass seem not possible/desirable.
