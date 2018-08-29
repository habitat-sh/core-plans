pkg_name=openssl-fips
pkg_origin=core
pkg_version=2.0.16
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The OpenSSL FIPS Object Module v2.0 provide cryptographic services to \
external applications. The FIPS Object Module provides an API for invocation \
of FIPS approved cryptographic functions from calling applications, and is \
designed for use in conjunction with standard OpenSSL 1.0.1 and 1.0.2 \
distributions. \
"
pkg_upstream_url="https://www.openssl.org"
pkg_license=('OpenSSL')
pkg_source="https://www.openssl.org/source/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="a3cd13d0521d22dd939063d3b4a0d4ce24494374b91408a05bdaca8b681c63d4"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/make
  core/perl
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  pushd "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
  ./config
  make
  popd
}

do_install() {
  pushd "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
  make INSTALLTOP="$pkg_prefix" install
  popd
}
