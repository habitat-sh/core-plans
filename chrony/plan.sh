pkg_name=chrony
pkg_origin=core
pkg_version=3.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Chrony is a versatile implementation of the Network Time Protocol (NTP)."
pkg_upstream_url="https://chrony.tuxfamily.org/"
pkg_license=("GPL-2.0")
pkg_source="https://download.tuxfamily.org/chrony/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="af77e47c2610a7e55c8af5b89a8aeff52d9a867dd5983d848b52d374bc0e6b9f"
pkg_deps=(
  core/glibc
  core/nss
  core/readline
  core/libcap
  core/libedit
  core/libseccomp
  core/nettle
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(
  bin
  sbin
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --enable-scfilter \
    --enable-ntp-signd
  make
}
