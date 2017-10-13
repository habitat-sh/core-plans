pkg_name=libxrender
pkg_distname=libXrender
pkg_origin=core
pkg_version=0.9.10
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X Rendering Extension client library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="c06d5979f86e64cabbde57c223938db0b939dff49fdb5a793a1d3d0396650949"
pkg_deps=(core/glibc core/xlib core/libxcb core/libxau core/libxdmcp)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto core/kbproto core/libpthread-stubs core/renderproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
