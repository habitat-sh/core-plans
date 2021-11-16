pkg_origin=core
pkg_name=krb5
pkg_version=1.19.2
pkg_description="Kerberos is a network authentication protocol. It is designed
  to provide strong authentication for client/server applications by using
  secret-key cryptography. "
pkg_upstream_url=http://web.mit.edu/kerberos/www/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source="http://web.mit.edu/kerberos/dist/$pkg_name/${pkg_version%.*}/$pkg_name-$pkg_version.tar.gz"
pkg_shasum=10453fee4e3a8f8ce6129059e5c050b8a65dab1c257df68b99b3112eaa0cdf6a
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
