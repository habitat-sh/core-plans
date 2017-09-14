pkg_name=ffmpeg
pkg_origin=core
pkg_version=3.3.2
pkg_description="A complete, cross-platform solution to record, convert and \
stream audio and video."
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1+' 'GPL-2.0+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://ffmpeg.org/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=84cf294b6b2115879f347ae74ab411876c4298e17d3a0db68a55338bb88fa594
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
  core/yasm
)
pkg_deps=(
  core/bzip2
  core/glibc
  core/gmp
  core/libwebp
  core/openjpeg
  core/xz
  core/zlib
)

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --disable-debug \
    --disable-static \
    --enable-avisynth \
    --enable-avresample \
    --enable-gmp \
    --enable-gpl \
    --enable-libopenjpeg \
    --enable-libwebp \
    --enable-shared \
    --enable-version3
  make
}

do_check() {
  make check
}
