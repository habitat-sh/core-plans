pkg_name=ocamlbuild
pkg_origin=core
pkg_version="0.11.0"
pkg_description="OCamlbuild is a generic build tool, that has built-in rules for building OCaml library and programs."
pkg_upstream_url="https://github.com/ocaml/ocamlbuild"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/ocamlbuild/archive/${pkg_version}.tar.gz"
pkg_shasum="1717edc841c9b98072e410f1b0bc8b84444b4b35ed3b4949ce2bec17c60103ee"
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

do_build() {
  make configure OCAMLBUILD_PREFIX="${pkg_prefix}" OCAMLBUILD_BINDIR="${pkg_prefix}/bin" OCAMLBUILD_LIBDIR="${pkg_prefix}/lib"
  make
}
