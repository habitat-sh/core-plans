pkg_name=ocaml
pkg_origin=core
pkg_version="4.07.0"
pkg_description="The OCAML compiler"
pkg_upstream_url="https://ocaml.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source="https://github.com/ocaml/ocaml/archive/${pkg_version}.tar.gz"
pkg_shasum="8dd39da81beaad53a158e71c428f902b609d8f7f33fedf37f15c56be6c4cf840"
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
