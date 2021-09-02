pkg_name=unibilium
pkg_origin=core
pkg_version="1.2.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-3.0')
pkg_source="https://github.com/mauke/$pkg_name/archive/v$pkg_version.tar.gz"
pkg_shasum=6045b4f6adca7b1123284007675ca71f718f70942d3a93d8b9fa5bd442006ec1
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
