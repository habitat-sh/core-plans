pkg_name=libtasn1
pkg_origin=core
pkg_version="4.18.0"
pkg_description="ASN.1 implementation"
pkg_upstream_url="https://www.gnu.org/software/libtasn1/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1-or-later')
pkg_source="https://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="4365c154953563d64c67a024b607d1ee75c6db76e0d0f65709ea80a334cd1898"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/bison
  core/busybox-static
  core/diffutils
  core/file
  core/gcc
  core/make
  core/pkg-config
  core/util-linux
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
