pkg_name="libpsl"
pkg_version="0.21.1"
pkg_origin="core"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The libpsl package provides a library for accessing and resolving information from the Public Suffix List (PSL). \
The PSL is a set of domain names beyond the standard suffixes, such as .com. "
pkg_upstream_url="http://xmlsoft.org/"
# https://github.com/rockdaboot/libpsl/tree/libpsl-0.21.0#license
pkg_license=('MIT' 'BSD-3-Clause')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/rockdaboot/libpsl/releases/download/${pkg_version}/libpsl-${pkg_version}.tar.gz"
pkg_shasum="ac6ce1e1fbd4d0254c4ddb9d37f1fa99dec83619c1253328155206b896210d4c"
# We build libpsl against libidn2 instead of libicu as libidn2 is a lot
# smaller than libicu: https://bugs.archlinux.org/task/52690
pkg_deps=(
	core/glibc
	core/libidn2
	core/libunistring
)
pkg_build_deps=(
	core/gettext
	core/gcc
	core/pkg-config
	core/python
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
	./configure \
		--prefix="$pkg_prefix"
	make
}

do_check() {
	make check
}
