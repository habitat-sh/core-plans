pkg_name=libxfixes
pkg_distname="libXfixes"
pkg_origin=core
pkg_version=5.0.3
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X.Org Libraries: libXfixes"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="de1cd33aff226e08cefd0e6759341c2c8e8c9faf8ce9ac6ec38d43e287b22ad6"
pkg_deps=(core/glibc core/xlib core/libxcb core/libxau core/libxdmcp)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto core/kbproto core/xextproto core/fixesproto core/libpthread-stubs)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
