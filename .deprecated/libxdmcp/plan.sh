pkg_name=libxdmcp
pkg_distname=libXdmcp
pkg_origin=core
pkg_version=1.1.2
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 Display Manager Control Protocol library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="81fe09867918fff258296e1e1e159f0dc639cb30d201c53519f25ab73af4e4e2"
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
