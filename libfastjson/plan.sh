pkg_name=libfastjson
pkg_origin=core
pkg_version=0.99.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_description="A fast JSON library for C."
pkg_upstream_url="https://github.com/rsyslog/libfastjson"
pkg_source="https://github.com/rsyslog/libfastjson/archive/v${pkg_version}.tar.gz"
pkg_shasum=7e49057b26a5a9e3c6623e024f95f9fd9a14b571b9150aeb89d6d475fc3633e3
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
