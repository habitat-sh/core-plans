source "$(dirname "${BASH_SOURCE[0]}")/../clang/plan.sh"

pkg_name=clang7
pkg_origin=core
pkg_version=7.1.0
pkg_license=('NCSA')
pkg_description="LLVM native C/C++/Objective-C compiler"
pkg_upstream_url="http://clang.llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="cfe-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz"
pkg_shasum="e97dc472aae52197a4d5e0185eb8f9e04d7575d2dc2b12194ddc768e0f8a846d"
clang_tools_extra_shasum="1ce0042c48ecea839ce67b87e9739cf18e7a5c2b3b9a36d177d00979609b6451"

pkg_build_deps=(
  core/llvm7
  core/perl
  core/cmake
  core/diffutils
  core/ninja
)
