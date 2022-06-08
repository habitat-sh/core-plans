# shellcheck disable=SC2148,SC1091
source ../ghc/plan.sh

pkg_name=ghc80
pkg_origin=core
pkg_version=8.0.2
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="11625453e1d0686b3fa6739988f70ecac836cadc30b9f0c8b49ef9091d6118b1"
pkg_dirname="ghc-${pkg_version}"

pkg_include_dirs=(lib/ghc-${pkg_version}/include)

pkg_build_deps=(
  core/binutils
  core/diffutils
  core/ghc710
  core/make
  core/patch
  core/sed
)
