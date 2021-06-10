pkg_name=libnsl
pkg_origin=core
pkg_version="1.3.0"
pkg_description="This library contains the public client interface for NIS(YP) and NIS+ in a IPv6 ready version"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.1-or-later")
pkg_upstream_url="https://github.com/thkukuk/libnsl"
pkg_source="https://github.com/thkukuk/libnsl/archive/v${pkg_version}.tar.gz"
pkg_shasum=8e88017f01dd428f50386186b0cd82ad06c9b2a47f9c5ea6b3023fc6e08a6b0f
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/diffutils
  core/gcc
  core/gettext
  core/libtirpc
  core/libtool
  core/make
  core/patch
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/gettext)/share/aclocal:$(pkg_path_for core/pkg-config)/share/aclocal:$(pkg_path_for core/libtool)/share/aclocal"
  export ACLOCAL_PATH

  autoreconf --force --install
  patch < "$PLAN_CONTEXT/autogen.patch"
  ./autogen.sh
}
