pkg_name=gsl
pkg_origin=core
pkg_version=2.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPLv3')
pkg_description="GSL is a numerical library for C and C++"
pkg_upstream_url="https://www.gnu.org/software/gsl/"
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=b782339fc7a38fe17689cb39966c4d821236c28018b6593ddb6fd59ee40786a8
pkg_build_deps=(core/make core/gcc core/diffutils)
pkg_deps=(core/glibc)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
   CFLAGS="$CFLAGS -O2"
}

do_check() {
    make check
}
