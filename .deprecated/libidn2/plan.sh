pkg_name=libidn2
pkg_origin=core
pkg_version="2.0.4"
pkg_description="Implementation of IDNA2008, Punycode and TR46 (Internationalized domain names)"
pkg_upstream_url="https://www.gnu.org/software/libidn/#libidn2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'LGPL-3.0')
pkg_source="https://ftp.gnu.org/gnu/libidn/libidn2-2.0.4.tar.gz"
pkg_shasum=644b6b03b285fb0ace02d241d59483d98bc462729d8bb3608d5cad5532f3d2f0
pkg_deps=(
  core/glibc
  core/libiconv
  core/libunistring
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/gettext
  core/make
  core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)


do_check() {
  make check
}
