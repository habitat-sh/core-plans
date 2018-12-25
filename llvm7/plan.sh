source "$(dirname "${BASH_SOURCE[0]}")/../llvm/plan.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../llvm/plan.sh"

pkg_name=llvm7
pkg_origin=core
pkg_version=7.0.1
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url="http://llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="llvm-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/llvm-${pkg_version}.src.tar.xz"
pkg_shasum="a38dfc4db47102ec79dcc2aa61e93722c5f6f06f0a961073bd84b78fb949419b"
