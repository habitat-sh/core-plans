pkg_name=ocaml
pkg_origin=core
pkg_version="4.04.1"
pkg_description="The OCAML compiler"
pkg_upstream_url="https://ocaml.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source="https://github.com/ocaml/ocaml/archive/${pkg_version}.tar.gz"
pkg_shasum="9aea1867848e370ae79f9aea4d48b04daf416478b0f43dfcb3a0f4d3ecf5f8e4"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix "${pkg_prefix}" -no-graph && make world.opt
}

do_check() {
  make bootstrap
}

do_strip() {
  return 0
}
