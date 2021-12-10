source "$(dirname "${BASH_SOURCE[0]}")/../bdwgc/plan.sh"

pkg_name=bdwgc8
pkg_origin=core
pkg_version=8.2.0
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/ivmai/bdwgc/releases/download/v${pkg_version}/gc-${pkg_version}.tar.gz"
pkg_dirname="gc-${pkg_version}"
pkg_shasum="2540f7356cb74f6c5b75326c6d38a066edd796361fd7d4ed26e494d9856fed8f"
