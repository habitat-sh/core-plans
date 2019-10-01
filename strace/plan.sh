pkg_name=strace
pkg_origin=core
pkg_version=5.3
pkg_license=("LGPL-2.1-or-later")
pkg_description="strace is a system call tracer for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://strace.io/"
pkg_source="https://github.com/strace/strace/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=6c131198749656401fe3efd6b4b16a07ea867e8f530867ceae8930bbc937a047
pkg_deps=(
  core/glibc
  core/libunwind
)
pkg_build_deps=(
  core/coreutils
  core/make
  core/gcc
  core/diffutils
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_check() {
  make check
}
