pkg_name=unibilium
pkg_origin=core
pkg_version="1.2.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-3.0')
pkg_source="https://github.com/mauke/$pkg_name/archive/v$pkg_version.tar.gz"
pkg_shasum="623af1099515e673abfd3cae5f2fa808a09ca55dda1c65a7b5c9424eb304ead8"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/gcc
  core/libtool
  core/make
  core/perl
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_description="A terminfo parsing library"
pkg_upstream_url="https://github.com/mauke/unibilium"

do_build() {
  make PREFIX="$pkg_prefix"
}

do_install() {
  make install PREFIX="$pkg_prefix"
}
