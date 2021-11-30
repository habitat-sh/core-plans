pkg_name=libunwind
pkg_origin=core
pkg_version=1.6.0
pkg_description="A C programming interface to determine the call-chain of a program."
# additional package info at https://github.com/libunwind/libunwind
pkg_upstream_url="http://www.nongnu.org/libunwind/"
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/libunwind/libunwind/archive/refs/tags/v${pkg_version}.tar.gz
pkg_shasum=205f41997c4e17d8e25966601c924e4ad93e6a3576bf59b6baa3eadababa6a5f
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/gcc
  core/make
  core/diffutils
  core/file
  core/coreutils
	core/autoconf
	core/automake
	core/libtool
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
	ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/libtool)/share/aclocal"
	export ACLOCAL_PATH
}

do_build() {
	autoreconf -i
	do_default_build
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_ls" ]]; then
    rm -fv /bin/ls
  fi
}
