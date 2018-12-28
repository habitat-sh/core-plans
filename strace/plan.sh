pkg_name=strace
pkg_origin=core
pkg_version=4.26
pkg_license=("BSD-3-Clause-LBNL")
pkg_description="strace is a system call tracer for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://strace.io/"
pkg_source="https://github.com/strace/strace/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=7c4d2ffeef4f7d1cdc71062ca78d1130eb52f947c2fca82f59f6a1183bfa1e1c
pkg_deps=(
  core/glibc
  core/libunwind
)
pkg_bin_dirs=(bin)
pkg_build_deps=(core/coreutils core/make core/gcc core/diffutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_check() {
  make check
}
