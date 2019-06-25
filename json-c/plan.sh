pkg_name=json-c
pkg_origin=core
pkg_version=0.13.1
pkg_description="A JSON implementation in C"
pkg_upstream_url=https://github.com/json-c/json-c
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://s3.amazonaws.com/json-c_releases/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=b87e608d4d3f7bfdd36ef78d56d53c74e66ab278d318b71e6002a369d36f4873
pkg_build_deps=(
  core/autoconf
  core/busybox-static
  core/gcc
  core/make
)
pkg_deps=(
  core/glibc
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  make check
}
