pkg_name=xtrans
pkg_origin=core
pkg_version=1.3.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 transport library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="adbd3b36932ce4c062cd10f57d78a156ba98d618bdb6f50664da327502bc8301"
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/pkg-config core/util-macros)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(share/pkgconfig)

do_check() {
    make check
}
