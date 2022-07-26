pkg_name=libffi
pkg_version=3.4.2
pkg_origin=core
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/libffi/libffi/releases/download/v${pkg_version}/libffi-${pkg_version}.tar.gz
pkg_upstream_url=https://sourceware.org/libffi
pkg_description="The libffi library provides a portable, high level programming interface to various calling conventions.\
  This allows a programmer to call any function specified by a call interface description at run-time."
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=540fb721619a6aba3bdeef7d940d8e9e0e6d2c193595bc243241b77ff9e93620
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
