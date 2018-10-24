source "$(dirname "${BASH_SOURCE[0]}")/../llvm/plan.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../llvm/plan.sh"

pkg_name=llvm7
pkg_origin=core
pkg_version=7.0.0
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url="http://llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="llvm-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/llvm-${pkg_version}.src.tar.xz"
pkg_shasum="8bc1f844e6cbde1b652c19c1edebc1864456fd9c78b8c1bea038e51b363fe222"
