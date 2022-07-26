pkg_name=freetype
pkg_version=2.11.0
pkg_origin=core
pkg_description="A software library to render fonts"
pkg_upstream_url="https://www.freetype.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('FreeType' 'GPL-2.0')
pkg_source=http://download.savannah.gnu.org/releases/freetype/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=a45c6b403413abd5706f3582f04c8339d26397c4304b78fa552f2215df64101f
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
)
pkg_deps=(
  core/coreutils
  core/bzip2
  core/glibc
  core/libpng
  core/zlib
  core/bash
  core/sed
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_install() {
  do_default_install

  build_line "Remove space from freetype-config interperter"
  sed -i 's@#! /bin/sh@#!/bin/sh@' "$CACHE_PATH/builds/unix/freetype-config"

  build_line "Copy freetype-config to bin"
  install "$CACHE_PATH/builds/unix/freetype-config" "$pkg_prefix/bin/"

  fix_interpreter "$pkg_prefix/bin/freetype-config" "core/bash" "bin/sh"
}
