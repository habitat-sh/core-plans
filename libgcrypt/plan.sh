pkg_name=libgcrypt
pkg_origin=core
pkg_version=1.9.2
pkg_license=('LGPL-2.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=b2c10d091513b271e47177274607b1ffba3d95b188bbfa8797f948aec9053c5a
pkg_deps=(
  core/glibc
  core/libgpg-error
)
pkg_build_deps=(
  core/gcc
  core/coreutils
  core/sed
  core/bison
  core/flex
  core/grep
  core/bash
  core/gawk
  core/libtool
  core/diffutils
  core/findutils
  core/xz
  core/gettext
  core/gzip
  core/make
  core/patch
  core/texinfo
  core/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url="https://www.gnupg.org/software/libgcrypt/index.html"
pkg_description="Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG."

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-static \
    --enable-shared
  make
}

do_check() {
  make check
}
