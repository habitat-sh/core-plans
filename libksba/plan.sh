pkg_name=libksba
pkg_origin=core
pkg_version=1.5.0
pkg_license=('LGPL-3.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/"${pkg_name}"/"${pkg_name}"-"${pkg_version}".tar.bz2
pkg_upstream_url="https://www.gnupg.org/software/libksba/index.html"
pkg_description="Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy."
pkg_shasum=ae4af129216b2d7fdea0b5bf2a788cd458a79c983bb09a43f4d525cc87aba0ba
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
