source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg3
pkg_origin=core
pkg_distname=ffmpeg
pkg_version=3.4.9
pkg_description="A complete, cross-platform solution to record, convert and stream audio and video."
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1-or-later' 'GPL-2.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ffmpeg.org/releases/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=afb2c2f8b97f202d6a9f7633bcb38bdebc3c54c5bad91278c50c4292aaac730f
pkg_dirname="ffmpeg-$pkg_version"

pkg_deps=(
  "${pkg_deps[@]}"
  core/patch
)

do_prepare() {
  patch -p1 < "${PLAN_CONTEXT}"/patches/000-libopenjpeg-2-4.patch
}
