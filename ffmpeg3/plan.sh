source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg3
pkg_origin=core
pkg_distname=ffmpeg
pkg_version=3.4.8
pkg_description="A complete, cross-platform solution to record, convert and stream audio and video."
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1-or-later' 'GPL-2.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ffmpeg.org/releases/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=839af372d8e52b1998aa67a433615e7607519107367af89a2714fa56f53d3d70
pkg_dirname="ffmpeg-$pkg_version"

pkg_deps=(
  "${pkg_deps[@]}"
  core/patch
)

do_prepare() {
  patch -p1 < "${PLAN_CONTEXT}"/patches/000-libopenjpeg-2-4.patch
}
