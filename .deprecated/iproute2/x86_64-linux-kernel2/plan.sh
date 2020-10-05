pkg_name=iproute2
pkg_origin=core
pkg_version=4.10.0
pkg_source="https://www.kernel.org/pub/linux/utils/net/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="22b1e1c1fc704ad35837e5a66103739727b8b48ac90b48c13f79b7367ff0a9a8"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Collection of utilities for controlling TCP/IP networking"
pkg_upstream_url="https://wiki.linuxfoundation.org/networking/iproute2"
pkg_license=('GPL-2.0')
pkg_bin_dirs=(sbin)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/bison
  core/flex
  core/gcc
  core/iptables
  core/m4
  core/make
  core/pkg-config
)
pkg_deps=(core/glibc)

do_build() {
  SBINDIR="$pkg_prefix/sbin"
  export SBINDIR
  do_default_build
}
