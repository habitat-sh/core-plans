pkg_name=libnl
pkg_origin=core
pkg_version="3.2.25"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.1-only")
pkg_upstream_url="https://www.infradead.org/~tgr/libnl/"
pkg_description="The libnl suite is a collection of libraries providing APIs to netlink protocol based Linux kernel interfaces."
pkg_source="https://www.infradead.org/~tgr/${pkg_name}/files/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="8beb7590674957b931de6b7f81c530b85dc7c1ad8fbda015398bc1e8d1ce8ec5"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/make
  core/gcc
  core/bison
  core/flex
  core/m4
)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_include_dirs=(include/libnl3)
pkg_bin_dirs=(sbin)

do_install() {
  do_default_install
  cp COPYING "${pkg_prefix}/"
}

do_check() {
  make test
}
