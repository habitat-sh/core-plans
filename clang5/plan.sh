source "$(dirname "${BASH_SOURCE[0]}")/../clang/plan.sh"

pkg_name=clang5
pkg_origin=core
pkg_version=5.0.1
pkg_license=('NCSA')
pkg_description="LLVM native C/C++/Objective-C compiler"
pkg_upstream_url="http://clang.llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="cfe-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz"
pkg_shasum="135f6c9b0cd2da1aff2250e065946258eb699777888df39ca5a5b4fe5e23d0ff"
clang_tools_extra_shasum="9aada1f9d673226846c3399d13fab6bba4bfd38bcfe8def5ee7b0ec24f8cd225"

pkg_build_deps=(
  core/llvm5
  core/perl
  core/cmake
  core/diffutils
  core/ninja
)

# Hint for rebuild scripts. Not a formal part of plan-build.
pkg_deprecated="true"
