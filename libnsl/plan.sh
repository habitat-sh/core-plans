pkg_name=libnsl
pkg_origin=core
pkg_version="1.2.0"
pkg_description="This library contains the public client interface for NIS(YP) and NIS+ in a IPv6 ready version"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.1-or-later")
pkg_upstream_url="https://github.com/thkukuk/libnsl"
pkg_source="https://github.com/thkukuk/libnsl/archive/v${pkg_version}.tar.gz"
pkg_shasum="a5a28ef17c4ca23a005a729257c959620b09f8c7f99d0edbfe2eb6b06bafd3f8"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/diffutils
  core/gcc
  core/gettext
  core/libtool
  core/make
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/gettext)/share/aclocal:$(pkg_path_for core/pkg-config)/share/aclocal"
  export ACLOCAL_PATH

  ./autogen.sh
}
