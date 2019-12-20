source "$(dirname "${BASH_SOURCE[0]}")/../ghc/plan.sh"

pkg_name=ghc86
pkg_origin=core
pkg_version=8.6.5
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="4d4aa1e96f4001b934ac6193ab09af5d6172f41f5a5d39d8e43393b9aafee361"
pkg_dirname="ghc-${pkg_version}"

pkg_build_deps=(
  core/coreutils
  core/binutils
  core/diffutils
  core/ghc84
  core/make
  core/patch
  core/sed
)

pkg_include_dirs=("lib/ghc-${pkg_version}/include")
