source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg3
pkg_distname=ffmpeg
pkg_version=3.4.8
pkg_source="https://ffmpeg.org/releases/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=839af372d8e52b1998aa67a433615e7607519107367af89a2714fa56f53d3d70
pkg_dirname="ffmpeg-$pkg_version"

pkg_deps=(
  "${pkg_deps[@]}"
  core/libidn2
)
