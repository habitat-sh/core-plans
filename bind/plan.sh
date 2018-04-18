pkg_name=bind
pkg_origin=core
pkg_version=9.11.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Versatile, Classic, Complete Name Server Software"
pkg_upstream_url="https://www.isc.org/downloads/bind/"
pkg_license=("MPL-2.0")
pkg_source="https://ftp.isc.org/isc/bind9/9.11.2/bind-${pkg_version}.tar.gz"
pkg_shasum="7f46ad8620f7c3b0ac375d7a5211b15677708fda84ce25d7aeb7222fe2e3c77a"
pkg_deps=(
  core/glibc
  core/libxml2
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/make
  core/perl
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
}

do_build() {
  ./configure --prefix="${pkg_prefix}" \
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
