pkg_name=xtrans
pkg_origin=core
pkg_version=1.4.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 transport library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="377c4491593c417946efcd2c7600d1e62639f7a8bbca391887e2c4679807d773"
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/pkg-config core/util-macros)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(share/pkgconfig)

do_check() {
    make check
}
