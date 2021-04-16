pkg_name=libksba
pkg_origin=core
pkg_version=1.5.1
pkg_license=('LGPL-3.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/"${pkg_name}"/"${pkg_name}"-"${pkg_version}".tar.bz2
pkg_upstream_url="https://www.gnupg.org/software/libksba/index.html"
pkg_description="Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy."
pkg_shasum=b0f4c65e4e447d9a2349f6b8c0e77a28be9531e4548ba02c545d1f46dc7bf921
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
