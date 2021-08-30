source ../libressl/plan.sh

pkg_name=libressl-musl
pkg_origin=core
# 2.9.2 is broken for musl
pkg_version=2.9.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Version of the TLS/crypto stack forked from OpenSSL"
pkg_license=('OpenSSL')
pkg_upstream_url=http://www.libressl.org/
pkg_shasum=39e4dd856694dc10d564201e4549c46d2431601a2b10f3422507e24ccc8f62f8
pkg_deps+=(core/musl)

# these two aren't changed from libressl, but due to version changing, need to be re-defined
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_source=http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${pkg_dirname}.tar.gz

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
}
