source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg4
pkg_origin=core
pkg_version=4.2.2
pkg_source="https://ffmpeg.org/releases/ffmpeg-${pkg_version}.tar.gz"
pkg_shasum=83f9a9aa0acf8036daf47494d99a8c31154a18ebb6841d89878ba47783559bd0
pkg_description="A complete, cross-platform solution to record, convert and stream audio and video."
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1-or-later' 'GPL-2.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_dirname="ffmpeg-${pkg_version}"
