source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg4
pkg_origin=core
pkg_version=4.1.3
pkg_source=https://ffmpeg.org/releases/ffmpeg-${pkg_version}.tar.gz
pkg_shasum=2f5b24f30e41963ce80f0ab7c78a1b91e86fb3fbb4a7661147c572c587177eee
pkg_description="A complete, cross-platform solution to record, convert and \
stream audio and video."
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1+' 'GPL-2.0+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_dirname="ffmpeg-$pkg_version"
