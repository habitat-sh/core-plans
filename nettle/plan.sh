pkg_name=nettle
pkg_origin=core
pkg_version=3.5.1
pkg_description="A low-level cryptographic library"
pkg_upstream_url="https://www.lysator.liu.se/~nisse/nettle/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-3.0-only' 'GPL-2.0-only' 'GPL-3.0-only')
pkg_source="https://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=75cca1998761b02e16f2db56da52992aef622bf55a3b45ec538bc2eedadc9419
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
