pkg_name=strace
pkg_origin=core
pkg_version=4.25
pkg_license=("BSD-3-Clause-LBNL")
pkg_description="strace is a system call tracer for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://strace.io/"
pkg_source="https://github.com/strace/strace/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=d685f8e65470b7832c3aff60c57ab4459f26ff89f07c10f92bd70ee89efac701
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
