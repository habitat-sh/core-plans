pkg_name=util-macros
pkg_origin=core
pkg_version=1.19.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X.Org X11 Autotools macros"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/util/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="0f812e6e9d2786ba8f54b960ee563c0663ddbe2434bf24ff193f5feab1f31971"
pkg_build_deps=(core/make)
pkg_pconfig_dirs=(share/pkgconfig)

do_check() {
    make check
}
