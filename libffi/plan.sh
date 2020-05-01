pkg_name=libffi
pkg_version=3.3
pkg_origin=core
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="ftp://sourceware.org/pub/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_upstream_url=https://sourceware.org/libffi
pkg_description="The libffi library provides a portable, high level programming interface to various calling conventions.\
  This allows a programmer to call any function specified by a call interface description at run-time."
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056
pkg_deps=(
  core/glibc
  core/libtool
)
pkg_build_deps=(
  core/coreutils
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(lib/"${pkg_name}"-"${pkg_version}"/include)

do_build() {
    ./configure \
      --prefix="${pkg_prefix}" \
      --disable-multi-os-directory
    make
}
