source "$(dirname "${BASH_SOURCE[0]}")/../bdwgc/plan.sh"

pkg_name=bdwgc7
pkg_origin=core
pkg_version=7.6.14
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/ivmai/bdwgc/releases/download/v${pkg_version}/gc-${pkg_version}.tar.gz"
pkg_dirname="gc-${pkg_version}"
pkg_shasum="b0df25b93d32a997890ef4bfa902bc8695a9b2f50b94296577ee29e4e33cde02"
