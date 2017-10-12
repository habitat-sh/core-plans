pkg_name=libxcb
pkg_origin=core
pkg_version=1.12
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 C Bindings"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/xcb/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="4adfb1b7c67e99bc9c2ccb110b2f175686576d2f792c8a71b9c8b19014057b5b"
pkg_deps=(core/glibc core/libxau core/libxdmcp core/inputproto)
pkg_build_deps=(core/gcc core/make core/pkg-config core/diffutils core/file core/python2 core/libxslt
                core/xproto core/xcb-proto core/libpthread-stubs core/util-macros)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
