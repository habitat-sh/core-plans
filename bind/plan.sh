pkg_name=bind
pkg_origin=core
pkg_version=9.13.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Versatile, Classic, Complete Name Server Software"
pkg_upstream_url="https://www.isc.org/downloads/bind/"
pkg_license=("MPL-2.0")
pkg_source="https://ftp.isc.org/isc/bind9/${pkg_version}/bind-${pkg_version}.tar.gz"
pkg_shasum="bbde0b81c66a7c7f5b074c8f0e714ed8aa235e4b930e28953cab0ae3cae94e4b"
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/libcap
  core/make
  core/perl
  core/python2
)
pkg_deps=(
  core/glibc
  core/libxml2
  core/openssl
  core/zlib
)
pkg_bin_dirs=(
  bin
  sbin
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  # The configure script expects `file` binaries to be in `/usr/bin`
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi

  pip install ply
}

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-libxml2="$(pkg_path_for "core/libxml2")" \
    --with-openssl="$(pkg_path_for "core/openssl")"
  make
}

do_end() {
  # Clean up
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
