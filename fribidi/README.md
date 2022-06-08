fribidi is a command-line interface to the libfribidi library and can be used to convert a logical string to visual output.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

libfribidi.so

contains functions used to implement the Unicode Bidirectional Algorithm

## Usage

Typically this is a runtime dependency that can be added to your
plan.sh:

    pkg_deps=(core/fribidi)
