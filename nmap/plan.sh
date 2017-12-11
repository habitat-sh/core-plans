pkg_name=nmap
pkg_origin=core
pkg_version=7.60
pkg_description="nmap is a free security scanner for network exploration and security audits"
pkg_upstream_url=https://nmap.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPLv2')
pkg_source=https://nmap.org/dist/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=a8796ecc4fa6c38aad6139d9515dc8113023a82e9d787e5a5fb5fa1b05516f21
pkg_deps=(
  core/glibc
  core/zlib
  core/nghttp2
)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
  core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
./configure
make
}

