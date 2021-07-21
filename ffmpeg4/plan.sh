source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg4
pkg_distname=ffmpeg
pkg_version=4.4
pkg_source="https://ffmpeg.org/releases/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=a4abede145de22eaf233baa1726e38e137f5698d9edd61b5763cd02b883f3c7c
pkg_dirname="ffmpeg-${pkg_version}"

pkg_deps=(
  "${pkg_deps[@]}"
  core/libidn2
)
