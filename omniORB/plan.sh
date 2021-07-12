pkg_name=omniORB
pkg_origin=core
pkg_version='4.2.4'
pkg_description="A CORBA object request broker for C++ and Python."
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=(
  'LGPL-2.0'
  'GPL-2.0'
  )
pkg_upstream_url="http://omniorb.sourceforge.net"
pkg_source="https://downloads.sourceforge.net/omniorb/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=28c01cd0df76c1e81524ca369dc9e6e75f57dc70f30688c99c67926e4bdc7a6f
pkg_deps=(
  core/coreutils
  core/gcc-libs
  core/glibc
)

pkg_build_deps=(
  core/autoconf
  core/gcc
  core/glib
  core/make
  core/openssl
  core/pkg-config
  core/python2
)

pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)


do_install() {
  do_default_install

  build_line "Fixing interpreters"
  fix_interpreter "$pkg_prefix/bin/omniidlrun.py" core/coreutils bin/env
}
