pkg_name=ocaml
pkg_origin=core
pkg_version="4.13.1"
pkg_description="The OCAML compiler"
pkg_upstream_url="https://ocaml.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source="https://github.com/ocaml/ocaml/archive/${pkg_version}.tar.gz"
pkg_shasum="194c7988cc1fd1c64f53f32f2f7551e5309e44d914d6efc7e2e4d002296aeac4"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix "${pkg_prefix}" && make world.opt
}

do_check() {
  make bootstrap
}

do_strip() {
  return 0
}
