pkg_name=ocamlbuild
pkg_origin=core
pkg_version="0.14.0"
pkg_description="OCamlbuild is a generic build tool, that has built-in rules for building OCaml library and programs."
pkg_upstream_url="https://github.com/ocaml/ocamlbuild"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/ocamlbuild/archive/${pkg_version}.tar.gz"
pkg_shasum=87b29ce96958096c0a1a8eeafeb6268077b2d11e1bf2b3de0f5ebc9cf8d42e78
pkg_deps=(
  core/glibc
  core/ocaml
  core/coreutils
  core/ncurses
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)

do_build() {
  make configure OCAMLBUILD_PREFIX="${pkg_prefix}" OCAMLBUILD_BINDIR="${pkg_prefix}/bin" OCAMLBUILD_LIBDIR="${pkg_prefix}/lib"
  make
}
