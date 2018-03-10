pkg_name=libssh2
pkg_origin=core
pkg_version=1.8.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="libssh2 is a client-side C library implementing the SSH2 protocol"
pkg_upstream_url="https://libssh2.org/"
pkg_license=('BSD-3-Clause')
pkg_source="https://libssh2.org/download/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="39f34e2f6835f4b992cafe8625073a88e5a28ba78f83e8099610a7b3af4676d4"
pkg_deps=(
  core/glibc
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/inetutils
  core/linux-headers
  core/make
  core/openssh
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

do_check() {
  # The ssh2.c test case expects USER to be set
  USER=root make check
}
