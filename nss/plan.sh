#!/bin/bash
pkg_name=nss
pkg_origin=core
pkg_version=3.63
pkg_license=("MPL-2.0")
pkg_description="Network Security Services"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS"
pkg_source="https://ftp.mozilla.org/pub/security/nss/releases/NSS_${pkg_version//./_}_RTM/src/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="182d2fef629102ae9423aabf2c192242b565cf5098e82c5a26cf70c5e4ea2221"
pkg_deps=(
  core/glibc
  core/nspr
  core/sqlite
  core/zlib
  core/gcc-libs
)
pkg_build_deps=(
  core/gcc
  core/make
  core/perl
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/nss)
pkg_lib_dirs=(lib)

do_prepare() {
  # Use LDFLAGS during linking
  sed -e "/\$(MKSHLIB) -o/ s/$/ \$(LDFLAGS)/" -i nss/coreconf/rules.mk
}

do_build() {
  cd ${pkg_name} || exit 1

  make -j1 BUILD_OPT=1 \
           NSS_USE_SYSTEM_SQLITE=1 \
           USE_SYSTEM_ZLIB=1 \
           USE_64=1 \
           XCFLAGS="${CFLAGS}"
}

do_install() {
  mkdir -p "${pkg_prefix}"/{bin,include/nss,lib}

  install -m0755 dist/Linux*/bin/{*util,derdump,pp,shlibsign,signtool,signver,ssltap,vfychain,vfyserv} "${pkg_prefix}"/bin
  install -m0644 dist/public/nss/*.h "${pkg_prefix}"/include/nss
  install -m0755 dist/Linux*/lib/*.so "${pkg_prefix}"/lib
  install -m0644 dist/Linux*/lib/{*.chk,libcrmf.a} "${pkg_prefix}"/lib
}
