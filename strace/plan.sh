pkg_name=strace
pkg_origin=core
pkg_version=4.23
pkg_license=("BSD-3-Clause-LBNL")
pkg_description="strace is a system call tracer for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://strace.io/"
pkg_source="https://github.com/strace/strace/releases/download/v4.23/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=7860a6965f1dd832747bd8281a04738274398d32c56e9fbd0a68b1bb9ec09aad
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
