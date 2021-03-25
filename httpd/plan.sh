pkg_name=httpd
pkg_origin=core
pkg_version=2.4.46
pkg_description="The Apache HTTP Server"
pkg_upstream_url="http://httpd.apache.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://archive.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=44b759ce932dc090c0e75c0210b4485ebf6983466fb8ca1b446c8168e1a1aec2
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
