source "$(dirname "${BASH_SOURCE[0]}")/../ffmpeg/plan.sh"

pkg_name=ffmpeg3
pkg_origin=core
pkg_version=3.4.6
pkg_source=https://ffmpeg.org/releases/ffmpeg-${pkg_version}.tar.gz
pkg_shasum=982cf1c409fab413648561c8d78167c7a75fe47b429dc7b5d5e956b19245040d
pkg_description="A complete, cross-platform solution to record, convert and \
stream audio and video."
pkg_upstream_url=https://ffmpeg.org/
pkg_license=('LGPL-2.1+' 'GPL-2.0+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_dirname="ffmpeg-$pkg_version"
