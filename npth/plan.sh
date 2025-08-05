pkg_name=npth
pkg_origin=core
pkg_version=1.6
pkg_license=('LGPL-3.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://gnupg.org/ftp/gcrypt/npth/npth-${pkg_version}.tar.bz2"
pkg_upstream_url="https://gnupg.org/software/npth/index.html"
pkg_description="nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation."
pkg_shasum="1393abd9adcf0762d34798dc34fdcf4d0d22a8410721e76f1e3afcd1daa4e2d1"
pkg_deps=(core/glibc)
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
