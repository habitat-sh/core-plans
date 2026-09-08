pkg_name=libffi
pkg_version=3.8.0
pkg_origin=core
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/libffi/libffi/releases/download/v${pkg_version}/libffi-${pkg_version}.tar.gz
pkg_upstream_url=https://sourceware.org/libffi
pkg_description="The libffi library provides a portable, high level programming interface to various calling conventions.\
  This allows a programmer to call any function specified by a call interface description at run-time."
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=7da3e2d9a171eb0a038f592ecad3ff2bb2550f3496d87b3b29ad0cf4430c0db4
pkg_deps=(core/glibc core/libtool)
pkg_build_deps=(
	core/coreutils
	core/make
	core/gcc
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  ./configure --prefix="${pkg_prefix}" --disable-multi-os-directory
  make
}
