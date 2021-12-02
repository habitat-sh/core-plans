pkg_name=libxpm
pkg_distname=libXpm
pkg_origin=core
pkg_version=3.5.12
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 miscellaneous utility library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="fd6a6de3da48de8d1bb738ab6be4ad67f7cb0986c39bd3f7d51dd24f7854bdec"
pkg_deps=(
    core/glibc
    core/libxt
    core/libxext
    core/xlib
    core/libxcb
    core/libxau
    core/libxdmcp
    core/libice
    core/libsm
)
pkg_build_deps=(
    core/gcc
    core/make
    core/pkg-config
    core/xextproto
    core/xproto
    core/kbproto
    core/libpthread-stubs
    core/gettext
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

_install_dependency() {
    local dep="${1}"
    if [[ -z "${NO_INSTALL_DEPS:-}" ]]; then
    $HAB_BIN pkg path "$dep" || $HAB_BIN install -u $HAB_BLDR_URL --channel $HAB_BLDR_CHANNEL "$dep" || {
        if [[ "$HAB_BLDR_CHANNEL" != "$FALLBACK_CHANNEL" ]]; then
            build_line "Trying to install '$dep' from '$FALLBACK_CHANNEL'"
            $HAB_BIN install -u $HAB_BLDR_URL --channel "$FALLBACK_CHANNEL" "$dep" || true
        fi
        }
    fi
    return 0
}

do_check() {
    make check
}
