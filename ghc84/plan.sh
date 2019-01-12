# shellcheck disable=SC2148,SC1091
source "$(dirname "${BASH_SOURCE[0]}")/../ghc/plan.sh"

pkg_name=ghc84
pkg_origin=core
pkg_version=8.4.4
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="11117735a58e507c481c09f3f39ae5a314e9fbf49fc3109528f99ea7959004b2"
pkg_dirname="ghc-${pkg_version}"

pkg_build_deps=(
  core/coreutils
  core/binutils
  core/diffutils
  core/ghc82
  core/make
  core/patch
  core/sed
)

pkg_include_dirs=(lib/ghc-${pkg_version}/include)
