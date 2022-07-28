pkg_name=iproute2
pkg_origin=core
pkg_version=4.20.0
pkg_source="https://www.kernel.org/pub/linux/utils/net/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="c8adaa6a40f888476b23acb283cfa30c0dd55f07b5aa20663ed5ba2ef1f6fda8"
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
  core/m4
  core/make
  core/pkg-config
)
pkg_deps=(
    core/glibc
    core/iptables
)

do_build() {
  SBINDIR="$pkg_prefix/sbin"
  export SBINDIR
  do_default_build
}
