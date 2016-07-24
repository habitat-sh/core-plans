pkg_name=rsync
pkg_version=3.1.2
pkg_origin=core
pkg_license=('GPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://download.samba.org/pub/${pkg_name}/src/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ecfa62a7fa3c4c18b9eccd8c16eaddee4bd308a76ea50b5c02a5840f09c0a1c2
pkg_deps=(core/glibc core/perl core/acl)
pkg_build_deps=(core/make core/gcc core/perl)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
