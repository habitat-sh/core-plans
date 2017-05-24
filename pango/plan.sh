pkg_name=pango
pkg_origin=core
pkg_version="1.40.6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="http://ftp.gnome.org/pub/GNOME/sources/pango/1.40/$pkg_name-$pkg_version.tar.xz"
pkg_shasum="ca152b7383a1e9f7fd74ae96023dc6770dc5043414793bfe768ff06b6759e573"
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
  CAIRO_LIBS="-L$(pkg_path_for core/cairo)/lib -lcairo"
  CAIRO_CFLAGS="-I$(pkg_path_for core/cairo)/include/cairo"
  FONTCONFIG_LIBS="-L$(pkg_path_for core/fontconfig)/lib -lfontconfig"
  FONTCONFIG_CFLAGS="-I$(pkg_path_for core/fontconfig)/include"
  FREETYPE_LIBS="-L$(pkg_path_for core/freetype)/lib -lfreetype"
  FREETYPE_CFLAGS="-I$(pkg_path_for core/freetype)/include/freetype2"
  GLIB_LIBS="-L$(pkg_path_for core/glib)/lib -lglib-2.0 -lgobject-2.0 -lgio-2.0"
  GLIB_CFLAGS="-I$(pkg_path_for core/glib)/include/glib-2.0 -I$(pkg_path_for core/glib)/include/glib-2.0/gobject -I$(pkg_path_for core/glib)/include/glib-2.0/glib -I$(pkg_path_for core/glib)/include/glib-2.0/gio -I$(pkg_path_for core/glib)/lib/glib-2.0/include"
  HARFBUZZ_LIBS="-L$(pkg_path_for core/harfbuzz)/lib -lharfbuzz"
  HARFBUZZ_CFLAGS="-I$(pkg_path_for core/harfbuzz)/include/harfbuzz"

  export CAIRO_LIBS CAIRO_CFLAGS FONTCONFIG_LIBS FONTCONFIG_CFLAGS FREETYPE_LIBS FREETYPE_CFLAGS GLIB_LIBS GLIB_CFLAGS HARFBUZZ_LIBS HARFBUZZ_CFLAGS

  fix_interpreter "$(pkg_path_for core/glib)/bin/glib-mkenums" core/coreutils bin/env

  ./configure --prefix="$pkg_prefix"
  make
}

do_install() {
  make install
}
