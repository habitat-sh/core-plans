pkg_name=strace
pkg_origin=core
pkg_version=5.11
pkg_license=("LGPL-2.1-or-later")
pkg_description="strace is a system call tracer for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://strace.io/
pkg_source="https://github.com/strace/strace/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=ffe340b10c145a0f85734271e9cce56457d23f21a7ea5931ab32f8cf4e793879
pkg_deps=(
  core/glibc
  core/libunwind
)
pkg_build_deps=(
  core/coreutils
  core/make
  core/gcc
  core/diffutils
  core/patch
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_prepare() {
  # thanks to https://www.linuxquestions.org/questions/showthread.php?p=6222340
  patch -i "${PLAN_CONTEXT}"/patches/000-binutils-wide.patch src/mpers.sh
}

do_check() {
  make check
}
