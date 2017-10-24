pkg_name=libsm
pkg_distname=libSM
pkg_origin=core
pkg_version=1.2.2
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 Session Management library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="0baca8c9f5d934450a70896c4ad38d06475521255ca63b717a6510fdb6e287bd"
pkg_deps=(core/glibc core/libice)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto core/xtrans)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
