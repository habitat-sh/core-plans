source "$(dirname "${BASH_SOURCE[0]}")/../clang/plan.sh"

pkg_name=clang7
pkg_origin=core
pkg_version=7.0.0
pkg_license=('NCSA')
pkg_description="LLVM native C/C++/Objective-C compiler"
pkg_upstream_url="http://clang.llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="cfe-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz"
pkg_shasum="550212711c752697d2f82c648714a7221b1207fd9441543ff4aa9e3be45bba55"
clang_tools_extra_shasum="937c5a8c8c43bc185e4805144744799e524059cac877a44d9063926cd7a19dbe"

pkg_build_deps=(
  core/llvm7
  core/perl
  core/cmake
  core/diffutils
  core/ninja
)
