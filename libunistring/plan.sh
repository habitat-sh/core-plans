pkg_name=libunistring
pkg_origin=core
pkg_version=0.9.6
pkg_description="Library functions for manipulating Unicode strings"
pkg_upstream_url="https://www.gnu.org/software/libunistring/"
pkg_license=('LGPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/gnu/libunistring/libunistring-${pkg_version}.tar.xz"
pkg_shasum=2df42eae46743e3f91201bf5c100041540a7704e8b9abfd57c972b2d544de41b
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
