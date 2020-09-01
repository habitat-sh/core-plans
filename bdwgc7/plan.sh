source "$(dirname "${BASH_SOURCE[0]}")/../bdwgc/plan.sh"

pkg_name=bdwgc7
pkg_origin=core
pkg_version=7.6.12
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/ivmai/bdwgc/releases/download/v${pkg_version}/gc-${pkg_version}.tar.gz"
pkg_dirname="gc-${pkg_version}"
pkg_shasum="6cafac0d9365c2f8604f930aabd471145ac46ab6f771e835e57995964e845082"
