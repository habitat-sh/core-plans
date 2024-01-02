pkg_name=xmlsec1
pkg_origin=core
pkg_version=1.2.39
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://www.aleksey.com/xmlsec/download/xmlsec1-${pkg_version}.tar.gz"
pkg_shasum="15f2f55ea5968e578fcd24b3b427e553876c86c147dc7f03923e98fc2768a1fa"
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
