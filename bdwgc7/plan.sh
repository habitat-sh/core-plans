source "$(dirname "${BASH_SOURCE[0]}")/../bdwgc/plan.sh"

pkg_name=bdwgc7
pkg_origin=core
pkg_version=7.6.10
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.hboehm.info/gc/gc_source/gc-${pkg_version}.tar.gz"
pkg_dirname="gc-${pkg_version}"
pkg_shasum="4fc766749a974700c576bbfb71b4a73b2ed746082e2fc8388bfb0b54b636af14"
