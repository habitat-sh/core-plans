source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg4
pkg_origin=core
pkg_version=4.3.2
pkg_source="https://ffmpeg.org/releases/ffmpeg-${pkg_version}.tar.gz"
pkg_shasum=b4701d5d1220cfa2f140090a0ae349cd76dafe335e60227d1e3f8301998634c9
pkg_description="A complete, cross-platform solution to record, convert and stream audio and video."
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
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1-or-later' 'GPL-2.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_dirname="ffmpeg-${pkg_version}"
