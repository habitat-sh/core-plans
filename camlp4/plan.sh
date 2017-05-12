pkg_name=camlp4
pkg_origin=core
pkg_version="4.04"
pkg_description="Camlp4 is a software system for writing extensible parsers for programming languages. It provides a set of OCaml libraries that are used to define grammars as well as loadable syntax extensions of such grammars."
pkg_upstream_url="https://github.com/ocaml/camlp4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source="https://github.com/ocaml/camlp4/archive/${pkg_version}+1.tar.gz"
pkg_dirname="${pkg_name}-${pkg_version}-1"
pkg_shasum="6044f24a44053684d1260f19387e59359f59b0605cdbf7295e1de42783e48ff1"
pkg_deps=(
  core/coreutils
  core/glibc
  core/ocaml
)
pkg_build_deps=(
  core/gcc
  core/make
  core/ocamlbuild
  core/which
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --bindir="${pkg_prefix}/bin" --libdir="${pkg_prefix}/lib" --pkgdir="${pkg_prefix}"
  make all
}

do_strip() {
  return 0
}
