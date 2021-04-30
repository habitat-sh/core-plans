pkg_name=ffmpeg
pkg_origin=core
pkg_version=4.3.2
pkg_description="A complete, cross-platform solution to record, convert and stream audio and video."
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1-or-later' 'GPL-2.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ffmpeg.org/releases/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=b4701d5d1220cfa2f140090a0ae349cd76dafe335e60227d1e3f8301998634c9
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/diffutils
  core/expat
  core/gcc
  core/libpng
  core/libtasn1
  core/make
  core/nettle
  core/p11-kit
  core/pkg-config
  core/yasm
)
pkg_deps=(
  core/bzip2
  core/fontconfig
  core/freetype
  core/glibc
  core/gnutls
  core/gmp
  core/libxext
  core/libdrm
  core/libwebp
  core/libxcb
  core/libxml2
  core/openjpeg
  core/xz
  core/zlib
  core/avisynthplus
)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
    --disable-debug \
    --disable-static \
    --enable-avisynth \
    --enable-avresample \
    --disable-stripping \
    --enable-fontconfig \
    --enable-gmp \
    --enable-gnutls \
    --enable-gpl \
    --enable-libdrm \
    --enable-libfreetype \
    --enable-libopenjpeg \
    --enable-libwebp \
    --enable-libxml2 \
    --enable-shared \
    --enable-version3
  make -j"$(nproc)"
}

do_check() {
  # ffmpeg links against itself and due to the nature of the Habitat build process, expects those libraries
  # to be present at /hab/pkgs/<pkg_ident>. Since do_check is called before do_install, those libraries are
  # not yet present, causing the tests to fail. We use LD_LIBRARY_PATH here to work around this chicken/egg
  # scenario, to provide the build paths of the libraries _only_ in the context of the do_check.
  local ffmpeg_path="$HAB_CACHE_SRC_PATH/${pkg_dirname}"

  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}":"${ffmpeg_path}/libavutil":"${ffmpeg_path}/libavcodec":"${ffmpeg_path}/libswresample"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}":"${ffmpeg_path}/libavdevice":"${ffmpeg_path}/libavfilter":"${ffmpeg_path}/libavformat"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}":"${ffmpeg_path}/libavresample":"${ffmpeg_path}/libpostproc":"${ffmpeg_path}/libswscale"

  make check

  unset LD_LIBRARY_PATH
}
