pkg_name=libtirpc
pkg_origin=core
pkg_version="1.0.3"
pkg_description="Libtirpc is a port of Suns Transport-Independent RPC library to Linux."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-3-Clause")
pkg_upstream_url="http://libtirpc.sourceforge.net/"
pkg_source="https://netix.dl.sourceforge.net/project/libtirpc/libtirpc/${pkg_version}/libtirpc-${pkg_version}.tar.bz2"
pkg_shasum="86c3a78fc1bddefa96111dd233124c703b22a78884203c55c3e06b3be6a0fd5e"
pkg_deps=(
  core/glibc
  core/krb5
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)
