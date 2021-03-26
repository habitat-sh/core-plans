pkg_name=dovecot
pkg_origin=core
pkg_version=2.3.14
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Secure IMAP server"
pkg_upstream_url="https://dovecot.org"
pkg_license=("LGPL-2.1" "MIT")
pkg_source="https://dovecot.org/releases/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="c8b3d7f3af1e558a3ff0f970309d4013a4d3ce136f8c02a53a3b05f345b9a34a"
pkg_deps=(
  core/bzip2
  core/glibc
  core/linux-pam
  core/lz4
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/make
  core/pkg-config
)
pkg_bin_dirs=(
  bin
  sbin
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  export CFLAGS="${CFLAGS} -O2"
  export CXXFLAGS="${CXXFLAGS} -O2"

  # The configure script expects `file` binaries to be in `/usr/bin`
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_end() {
  # Clean up
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
