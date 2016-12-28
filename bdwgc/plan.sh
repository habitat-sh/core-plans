pkg_name=bdwgc
pkg_origin=core
pkg_version=7.4.4
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.hboehm.info/gc/gc_source/gc-${pkg_version}.tar.gz"
pkg_shasum=e5ca9b628b765076b6ab26f882af3a1a29cde786341e08b9f366604f74e4db84
pkg_deps=(core/glibc core/libatomic_ops)
pkg_build_deps=(core/gcc core/make core/diffutils core/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname="gc-${pkg_version}"

do_check() {
  make check
}
