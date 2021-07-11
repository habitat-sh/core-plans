pkg_name=xmlsec1
pkg_origin=core
pkg_version=1.2.31
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="http://www.aleksey.com/xmlsec/download/xmlsec1-${pkg_version}.tar.gz"
pkg_shasum=9b10bc52cc31e4f76162e3975e50db26b71ab49c571d810b311ca626be5a0b26
pkg_deps=(
  core/glibc
  core/zlib
  core/libxml2
  core/libgcrypt
  core/libtool
)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="XML Security Library is a C library based on LibXML2."
pkg_upstream_url=https://www.aleksey.com/xmlsec/index.html
