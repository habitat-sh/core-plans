pkg_name=parallel
pkg_origin=core
pkg_version=20200622
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="GNU parallel is a shell tool for executing jobs in parallel using one or more computers."
pkg_upstream_url="https://www.gnu.org/software/parallel/"
pkg_source="https://ftp.gnu.org/gnu/parallel/parallel-${pkg_version}.tar.bz2"
pkg_shasum=ff8fafe192a76850e5640b98adb6428f8bdd85ef52c7c43787438c0ac3bc1d3f
pkg_deps=(
  core/glibc
  core/coreutils
  core/perl
)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)

do_install() {
  do_default_install
  fix_interpreter "${pkg_prefix}/bin/*" core/coreutils bin/env
}
