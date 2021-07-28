pkg_name=pango
pkg_origin=core
pkg_version="1.48.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="418913fb062071a075846244989d4a67aa5c80bf0eae8ee4555a092fd566a37a"
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
)
pkg_build_deps=(
  core/cmake
  core/coreutils
  core/diffutils
  core/file
  core/gcc
  core/git
  core/meson
  core/perl
  core/pkg-config
  core/util-linux
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
  meson _build -Dprefix="$pkg_prefix"
  ninja -C _build
}

do_install() {
  ninja -C _build install
}
