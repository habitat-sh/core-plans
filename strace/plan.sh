pkg_name=strace
pkg_origin=core
pkg_version=5.2
pkg_license=("LGPL-2.1-or-later")
pkg_description="strace is a system call tracer for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://strace.io/"
pkg_source="https://github.com/strace/strace/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=d513bc085609a9afd64faf2ce71deb95b96faf46cd7bc86048bc655e4e4c24d2
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
