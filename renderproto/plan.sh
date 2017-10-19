pkg_name=renderproto
pkg_distname=renderproto
pkg_origin=core
pkg_version=0.11.1
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 Render extension wire protocol"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="06735a5b92b20759204e4751ecd6064a2ad8a6246bb65b3078b862a00def2537"
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
