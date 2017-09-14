pkg_name=libressl
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=2.4.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Version of the TLS/crypto stack forked from OpenSSL"
pkg_license=('OpenSSL')
pkg_upstream_url=http://www.libressl.org/
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_source=http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${pkg_dirname}.tar.gz
pkg_shasum=6fcfaf6934733ea1dcb2f6a4d459d9600e2f488793e51c2daf49b70518eebfd1
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
