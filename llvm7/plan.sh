source "$(dirname "${BASH_SOURCE[0]}")/../llvm/plan.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../llvm/plan.sh"

pkg_name=llvm7
pkg_origin=core
pkg_version=7.1.0
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url="http://llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="llvm-${pkg_version}.src.tar.xz"
pkg_source="https://github.com/llvm/llvm-project/releases/download/llvmorg-${pkg_version}/llvm-${pkg_version}.src.tar.xz"
pkg_shasum="512a9a8e0f7a2cf09dd26c8789582623d84bfa707275cbeecdb26c603d9c314e"
