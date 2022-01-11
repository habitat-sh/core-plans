pkg_name=pango
pkg_origin=core
pkg_version="1.41.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_filename=${pkg_name}-${pkg_version}.tar.xz
pkg_shasum="1353a4cf5227299294955d0c6232326b346b087ebac6496241d54ca5d2e2abc3"
pkg_upstream_url="http://www.pango.org"
pkg_description="Pango is a library for laying out and rendering of text, with an emphasis on internationalization."
pkg_deps=(
  core/bzip2
  core/cairo
  core/pixman
  core/gcc-libs
  core/glib
  core/glibc
  core/pcre
  core/libffi
  core/zlib
  core/fontconfig
  core/freetype
  core/libpng
  core/xproto
  core/libxau
  core/libxcb
  core/libxdmcp
  core/expat
  core/util-linux
  core/harfbuzz
)
pkg_build_deps=(
  core/file
  core/gcc
  core/cmake
  core/pkg-config
  core/cacerts
  core/curl
  duddela_tryhabitat/fribidi
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_download() {
  # Downloading from https://download.gnome.org/ with wget results in a 302.
  # Override `do_download` to use `curl`.
  pushd $HAB_CACHE_SRC_PATH > /dev/null
  if [[ -f $pkg_filename ]]; then
    build_line "Found previous file '${pkg_filename}', attempting to re-use"
    if verify_file $pkg_filename $pkg_shasum; then
      build_line "Using cached and verified '${pkg_filename}'"
      return 0
    else
      build_line "Clearing previous '${pkg_filename}' and re-attempting download"
      rm -fv $pkg_filename
    fi
  fi

  build_line "Downloading '${pkg_source}' to '${pkg_filename}' with curl"
  curl -L -O $pkg_source --cacert $(pkg_path_for cacerts)/ssl/cert.pem
  build_line "Downloaded '${pkg_filename}'";
  popd > /dev/null
}
