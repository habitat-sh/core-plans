pkg_origin=core
pkg_name=krb5
pkg_version=1.14.3
pkg_description="Kerberos is a network authentication protocol. It is designed
  to provide strong authentication for client/server applications by using
  secret-key cryptography. "
pkg_upstream_url=http://web.mit.edu/kerberos/www/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source="http://web.mit.edu/kerberos/dist/$pkg_name/${pkg_version%.*}/$pkg_name-$pkg_version.tar.gz"
pkg_shasum=cd4620d520cf0df0dd8791309912df2bb20fcba76790b9fba4e25c1da08ff2c9
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/bison
  core/busybox
  core/gcc
  core/m4
  core/make
  core/perl
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  cd src || exit
  do_default_build
}

do_install() {
  cd src || exit
  do_default_install
}
