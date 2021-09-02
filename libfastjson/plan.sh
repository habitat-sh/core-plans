pkg_name=libfastjson
pkg_origin=core
pkg_version=0.99.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_description="A fast JSON library for C."
pkg_upstream_url="https://github.com/rsyslog/libfastjson"
pkg_source="https://github.com/rsyslog/libfastjson/archive/v${pkg_version}.tar.gz"
pkg_shasum=881f954633aa76931e4c756ece0bda6fd8a673c6e66955a3db3b2bb9d6bbff72
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/make
  core/gcc
  core/libtool
  core/autoconf
  core/automake
  core/pkg-config
  core/diffutils
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/libtool)/share/aclocal"
  export ACLOCAL_PATH
  ./autogen.sh
  do_default_build
}

do_check() {
  make check
}
