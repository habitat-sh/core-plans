pkg_name=monit
pkg_origin=core
pkg_version="5.25.2"
pkg_upstream_url="https://mmonit.com/monit"
pkg_description="Monit. Barking at daemons"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('AGPL-3.0')
pkg_source="https://mmonit.com/monit/dist/monit-${pkg_version}.tar.gz"
pkg_shasum="aa0ce6361d1155e43e30a86dcff00b2003d434f221c360981ced830275abc64a"
pkg_deps=(
  core/bash
  core/glibc
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root
pkg_exports=(
  [port]=httpd.port
)
pkg_exposes=(port)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-optimized \
    --without-pam \
    --with-ssl-incl-dir="$(pkg_path_for core/openssl)/include"
  make
}
