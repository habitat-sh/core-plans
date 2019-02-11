source "$(dirname "${BASH_SOURCE[0]}")/../llvm/plan.sh"

pkg_name=llvm5
pkg_origin=core
pkg_version=5.0.1
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url="http://llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="llvm-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/llvm-${pkg_version}.src.tar.xz"
pkg_shasum="5fa7489fc0225b11821cab0362f5813a05f2bcf2533e8a4ea9c9c860168807b0"
pkg_deps=(
  core/coreutils
  core/gcc-libs
  core/glibc
  core/libffi
  core/python2
  core/zlib
)
pkg_build_deps=(
  core/cmake
  core/diffutils
  core/gcc
  core/ninja
)

# Hint for rebuild scripts. Not a formal part of plan-build.
pkg_deprecated="true"
