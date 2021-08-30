pkg_name=libcap-ng
pkg_origin=core
pkg_version=0.8.2
pkg_source=http://people.redhat.com/sgrubb/$pkg_name/$pkg_name-$pkg_version.tar.gz
pkg_shasum=52c083b77c2b0d8449dee141f9c3eba76e6d4c5ad44ef05df25891126cb85ae9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library"
pkg_upstream_url="https://people.redhat.com/sgrubb/libcap-ng/"
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_build_deps=(core/make core/gcc)
pkg_deps=(core/glibc)

do_build() {
  ./configure --prefix="${pkg_prefix}" --enable-static=no --with-python=no
  make
}
