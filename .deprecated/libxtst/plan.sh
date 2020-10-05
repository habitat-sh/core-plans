pkg_name=libxtst
pkg_distname=libXtst
pkg_origin=core
pkg_version=1.2.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X.Org Libraries: libXtst"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="4655498a1b8e844e3d6f21f3b2c4e2b571effb5fd83199d428a6ba7ea4bf5204"
pkg_deps=(core/glibc core/xlib core/libxcb core/libxau core/libxdmcp core/libxext core/libxi)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto core/kbproto core/renderproto core/inputproto core/xextproto core/libpthread-stubs core/libxfixes core/fixesproto core/recordproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_dirname="${pkg_distname}-${pkg_version}"

do_check() {
  make check
}
