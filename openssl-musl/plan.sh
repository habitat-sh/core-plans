source ../openssl/plan.sh

pkg_name=openssl-musl
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
OpenSSL is an open source project that provides a robust, commercial-grade, \
and full-featured toolkit for the Transport Layer Security (TLS) and Secure \
Sockets Layer (SSL) protocols. It is also a general-purpose cryptography \
library.\
"
pkg_upstream_url="https://www.openssl.org"
pkg_license=('OpenSSL')
pkg_deps=(
  core/musl
  core/zlib-musl
  core/cacerts
)

do_prepare() {
  PLAN_CONTEXT="$(abspath "$PLAN_CONTEXT/../openssl")" _common_prepare

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"

  export BUILD_CC=musl-gcc
  build_line "Setting BUILD_CC=$BUILD_CC"
}

do_build() {
  # Set PERL var for scripts in `do_check` that use Perl
  PERL=$(pkg_path_for core/perl)/bin/perl
  export PERL
  "$(pkg_path_for core/perl)/bin/perl" ./Configure \
    no-idea \
    no-mdc2 \
    no-rc5 \
    no-sslv2 \
    no-sslv3 \
    no-comp \
    no-zlib \
    shared \
    disable-gost \
    --prefix="${pkg_prefix}" \
    --openssldir=ssl \
    linux-x86_64

  make CC= depend
  make --jobs="$(nproc)" CC="$BUILD_CC"
}
