pkg_name=libunistring
pkg_origin=core
pkg_version=0.9.10
pkg_description="Library functions for manipulating Unicode strings"
pkg_upstream_url="https://www.gnu.org/software/libunistring/"
pkg_license=('LGPL-3.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/gnu/libunistring/libunistring-${pkg_version}.tar.xz"
pkg_shasum=eb8fb2c3e4b6e2d336608377050892b54c3c983b646c561836550863003c05d7
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_check() {
  make check
}
