pkg_name=sqlite
pkg_version=3.31.1
pkg_dist_version=3310100
pkg_origin=core
pkg_license=('Public Domain')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine."
pkg_upstream_url=https://www.sqlite.org/
pkg_source="https://www.sqlite.org/2020/${pkg_name}-autoconf-${pkg_dist_version}.tar.gz"
pkg_filename="${pkg_name}-autoconf-${pkg_dist_version}.tar.gz"
pkg_dirname="${pkg_name}-autoconf-${pkg_dist_version}"
pkg_shasum=62284efebc05a76f909c580ffa5c008a7d22a1287285d68b7825a2b6b51949ae
pkg_deps=(
  core/glibc
  core/readline
)
pkg_build_deps=(
  core/gcc
  core/make
  core/coreutils
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
