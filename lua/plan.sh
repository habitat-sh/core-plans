pkg_origin=core
pkg_name=lua
pkg_version=5.3.3
pkg_description="A powerful, efficient, lightweight, embeddable scripting language"
pkg_upstream_url="https://www.lua.org/"
pkg_license=("MIT")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://www.lua.org/ftp/lua-${pkg_version}.tar.gz"
pkg_shasum=5113c06884f7de453ce57702abaac1d618307f33f6789fa870e87a59d772aca2
pkg_deps=(core/glibc core/readline)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
    make linux MYCFLAGS="$CFLAGS" MYLDFLAGS="$LDFLAGS" INSTALL_TOP=$pkg_prefix
}

do_check() {
    make test
}

do_install() {
    make install INSTALL_TOP="$pkg_prefix"
}
