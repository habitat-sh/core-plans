pkg_name=pango
pkg_origin=core
pkg_version="1.40.6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="http://ftp.gnome.org/pub/GNOME/sources/pango/1.40/$pkg_name-$pkg_version.tar.xz"
pkg_shasum="ca152b7383a1e9f7fd74ae96023dc6770dc5043414793bfe768ff06b6759e573"
pkg_upstream_url="http://www.pango.org"
pkg_description="Pango is a library for laying out and rendering of text, with an emphasis on internationalization."
pkg_deps=(
  core/cairo
  core/bzip2
  core/coreutils
  core/fontconfig
  core/freetype
  core/glib
  core/glibc
  core/harfbuzz
  core/libpng
  core/pcre
  core/pixman
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/expat
  core/file
  core/gcc
  core/libffi
  core/make
  core/patch
  core/perl
  core/pkg-config
   core/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/pango-1.0/pango)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [ ! -e /usr/bin/file ]
  then
    ln -sv "$(pkg_path_for core/file)/bin/file" /usr/bin/file
  fi
}

do_build() {
  fix_interpreter "$(pkg_path_for core/glib)/bin/glib-mkenums" core/coreutils bin/env

  ./configure --prefix="$pkg_prefix"
  make
}

do_install() {
  make install
}
