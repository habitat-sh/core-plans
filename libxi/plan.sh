pkg_name=libxi
pkg_distname=libXi
pkg_origin=core
pkg_version=1.7.10
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X.Org Libraries: libXi"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="36a30d8f6383a72e7ce060298b4b181fd298bc3a135c8e201b7ca847f5f81061"
pkg_deps=(core/glibc core/xlib core/libxext core/libxcb core/libxau core/libxdmcp)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto core/xextproto core/kbproto core/inputproto core/libpthread-stubs core/libxfixes core/fixesproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
