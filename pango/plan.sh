pkg_name=pango
pkg_origin=core
pkg_version="1.50.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="4add05edf51c1fb375a1ccde7498914120e23cb280dd7395b1aeb441f1838a4c"
pkg_upstream_url="http://www.pango.org"
pkg_description="Pango is a library for laying out and rendering of text, with an emphasis on internationalization."
pkg_deps=(
  core/bzip2
  core/cairo
  core/expat
  core/fontconfig
  core/freetype
  core/gcc-libs
  core/glib
  core/glibc
  core/harfbuzz
  core/libffi
  core/libice
  core/libiconv
  core/libpng
  core/libsm
  core/libxau
  core/libxcb
  core/libxdmcp
  core/libxext
  core/pcre
  core/pixman
  core/xlib
  core/zlib
  core/cmake
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/file
  core/gcc
  core/make
  core/perl
  core/pkg-config
  core/meson
  duddela_tryhabitat/fribidi
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [ ! -e /usr/bin/file ]
  then
    ln -sv "$(pkg_path_for core/file)/bin/file" /usr/bin/file
  fi
}
do_build() {
	meson _build -Dprefix="$pkg_prefix" --buildtype=release --wrap-mode=nofallback 
	ninja -C _build
}

