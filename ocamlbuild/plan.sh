pkg_name=ocamlbuild
pkg_origin=core
pkg_version="0.14.0"
pkg_description="OCamlbuild is a generic build tool, that has built-in rules for building OCaml library and programs."
pkg_upstream_url="https://github.com/ocaml/ocamlbuild"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/ocamlbuild/archive/${pkg_version}.tar.gz"
pkg_shasum="c02adf52ec18d3e634baa546d22888e7aabbd7424b7e82d30104e697b1c88236"
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
