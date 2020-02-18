source "$(dirname "${BASH_SOURCE[0]}")/../bdwgc/plan.sh"

pkg_name=bdwgc8
pkg_origin=core
pkg_version=8.0.4
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.hboehm.info/gc/gc_source/gc-${pkg_version}.tar.gz"
pkg_dirname="gc-${pkg_version}"
pkg_shasum="436a0ddc67b1ac0b0405b61a9675bca9e075c8156f4debd1d06f3a56c7cd289d"
