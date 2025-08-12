pkg_name=libcap-ng
pkg_origin=core
pkg_version="0.8.5"
pkg_source="https://github.com/stevegrubb/libcap-ng/archive/refs/tags/v${pkg_version}.tar.gz"
pkg_shasum="e4be07fdd234f10b866433f224d183626003c65634ed0552b02e654a380244c2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library"
pkg_upstream_url="https://people.redhat.com/sgrubb/libcap-ng/"
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_deps=(core/glibc)
pkg_build_deps=(
	core/make
	core/gcc
	core/automake
	core/autoconf
	core/libtool
	core/m4
)

do_build() {
	libtoolize
	./autogen.sh
	./configure --prefix="${pkg_prefix}" --enable-static=no --with-python=no
	make
}
