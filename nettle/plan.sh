pkg_name=nettle
pkg_origin=core
pkg_version="3.4.1"
pkg_description="a low-level cryptographic library"
pkg_upstream_url="https://www.lysator.liu.se/~nisse/nettle/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-3.0' 'GPL-2.0' 'GPL-3.0')
pkg_source="https://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="f941cf1535cd5d1819be5ccae5babef01f6db611f9b5a777bae9c7604b8a92ad"
pkg_deps=(
  core/glibc
  core/gmp
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/m4
  core/make
  core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  export LD_RUN_PATH
  LD_RUN_PATH="${LD_RUN_PATH}:$(pkg_path_for "core/gcc")/lib"

  make check
}
