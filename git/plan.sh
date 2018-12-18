pkg_name=git
pkg_version=2.18.0
pkg_origin=core
pkg_description="Git is a free and open source distributed version control
  system designed to handle everything from small to very large projects with
  speed and efficiency."
pkg_upstream_url=https://git-scm.com/
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.kernel.org/pub/software/scm/git/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=94faf2c0b02a7920b0b46f4961d8e9cad08e81418614102898a55f980fa3e7e4
pkg_deps=(
  core/cacerts
  core/curl
  core/expat
  core/gettext
  core/gcc-libs
  core/glibc
  core/openssh
  core/perl
  core/sed
  core/zlib
)
pkg_build_deps=(core/make core/gcc)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_prepare() {
  local perl_path
  perl_path="$(pkg_path_for perl)/bin/perl"
  sed -e "s#/usr/bin/perl#$perl_path#g" -i Makefile
}
