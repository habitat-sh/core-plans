pkg_name=ocaml
pkg_origin=core
pkg_version="4.04.0"
pkg_description="The OCAML compiler"
pkg_upstream_url="https://ocaml.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source="https://github.com/ocaml/ocaml/archive/${pkg_version}.tar.gz"
pkg_shasum="03e49d09d5a509216ca0cc8fccd10df3ad9dd441d7633e89974a74e149be3c51"
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
