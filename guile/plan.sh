pkg_name=guile
pkg_origin=core
pkg_version=2.2.7
pkg_description="An implementation of the Scheme programming language, used in many GNU programs as an extension language."
pkg_upstream_url="https://www.gnu.org/software/guile/"
pkg_license=('LGPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/pub/gnu/guile/guile-${pkg_version}.tar.xz"
pkg_shasum=cdf776ea5f29430b1258209630555beea6d2be5481f9da4d64986b077ff37504
pkg_deps=(core/bdwgc
  core/gcc-libs
  core/glibc
  core/gmp
  core/libatomic_ops
  core/libffi
  core/libtool
  core/libunistring
  core/readline)
pkg_build_deps=(core/diffutils core/gcc core/make core/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  LDFLAGS="-lgcc_s ${LDFLAGS}"
  export LDFLAGS
}

do_check() {
  make check
}
