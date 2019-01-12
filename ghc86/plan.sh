source "$(dirname "${BASH_SOURCE[0]}")/../ghc/plan.sh"

pkg_name=ghc86
pkg_origin=core
pkg_version=8.6.3
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="9f9e37b7971935d88ba80426c36af14b1e0b3ec1d9c860f44a4391771bc07f23"
pkg_dirname="ghc-${pkg_version}"
