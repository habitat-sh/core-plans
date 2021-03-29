pkg_name=cppunit
pkg_origin=core
pkg_version='1.15.1'
pkg_description="CppUnit is the C++ port of the famous JUnit framework for unit testing. Test output is in XML for automatic testing and GUI based for supervised tests."
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('LGPL-2.1')
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/cppunit/"
pkg_source="http://dev-www.libreoffice.org/src/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="89c5c6665337f56fd2db36bc3805a5619709d51fb136e51937072f63fcc717a7"
pkg_deps=(
  core/bash
  core/gcc-libs
)

pkg_build_deps=(
  core/autoconf
  core/automake
  core/gcc
  core/glib
  core/libtool
  core/make
  core/pkg-config
  core/which
)

pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  build_line "Fixing 'bin/env' interpreter for autogen.sh"
  fix_interpreter "$HAB_CACHE_SRC_PATH/$pkg_dirname/autogen.sh" core/bash bin/sh
}

do_build() {
  ./autogen.sh
  ./configure --prefix="$pkg_prefix"
  make
}

do_check() {
  make check
}
