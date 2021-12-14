pkg_name=httpd
pkg_origin=core
pkg_version=2.4.51
pkg_description="The Apache HTTP Server"
pkg_upstream_url="http://httpd.apache.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://archive.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=c2cedb0b47666bea633b44d5b3a2ebf3c466e0506955fbc3012a5a9b078ca8b4
pkg_deps=(
  core/apr
  core/apr-util
  core/bash
  core/expat
  core/gcc-libs
  core/glibc
  core/libiconv
  core/openssl
  core/pcre
  core/perl
  core/zlib
  core/sed
  core/grep
)
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_exports=(
  [port]=serverport
)
pkg_exposes=(port)
pkg_svc_run="httpd -DFOREGROUND -f ${pkg_svc_config_path}/httpd.conf"
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-expat="$(pkg_path_for core/expat)" \
    --with-iconv="$(pkg_path_for core/libiconv)" \
    --with-pcre="$(pkg_path_for core/pcre)" \
    --with-apr="$(pkg_path_for core/apr)" \
    --with-apr-util="$(pkg_path_for core/apr-util)" \
    --with-z="$(pkg_path_for core/zlib)" \
    --with-ssl="$(pkg_path_for core/openssl)" \
    --enable-modules="none" \
    --enable-mods-static="none" \
    --enable-mods-shared="reallyall" \
    --enable-mpms-shared="prefork event worker"
  make
}
