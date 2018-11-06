# clang-tools-extra (deprecated)

**Deprecation Notice**: This plan is folded into the `core/clang` package as that is what the normal way to build as defined [here](https://clang.llvm.org/get_started.html)

Clang Tools are standalone command line (and potentially GUI) tools designed for use by C++
developers who are already using and enjoying Clang as their compiler. These tools provide
developer-oriented functionality such as fast syntax checking, automatic formatting, refactoring,
etc.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Include `core/clang-tools-extra` if you need any of the extra clang tools.  For additional
usage, refer to the [`pkg_upstream_url`](https://clang.llvm.org/docs/ClangTools.html#extra-clang-tools)
