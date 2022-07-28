pkg_name=libxau
pkg_distname=libXau
pkg_origin=core
pkg_version=1.0.9
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 authorization library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="ccf8cbf0dbf676faa2ea0a6d64bcc3b6746064722b606c8c52917ed00dcb73ec"
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
