source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg4
pkg_origin=core
pkg_distname=ffmpeg
pkg_version=4.4.1
pkg_description="A complete, cross-platform solution to record, convert and stream audio and video."
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1-or-later' 'GPL-2.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ffmpeg.org/releases/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=82c98f74777f623710b72f9a3389fd38c1ed93bc661107e65df19234e395f6b9
pkg_dirname="ffmpeg-${pkg_version}"

pkg_deps=(
  "${pkg_deps[@]}"
  core/libidn2
)
