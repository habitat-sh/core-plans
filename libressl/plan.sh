pkg_name=libressl
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=2.9.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Version of the TLS/crypto stack forked from OpenSSL"
pkg_license=('OpenSSL')
pkg_upstream_url=http://www.libressl.org/
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_source=http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${pkg_dirname}.tar.gz
pkg_shasum=c4c78167fae325b47aebd8beb54b6041d6f6a56b3743f4bd5d79b15642f9d5d4
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/diffutils
  core/file
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  export CC=gcc
  build_line "Setting CC=$CC"
}

do_check() {
  make check
}
