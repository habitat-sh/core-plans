source "$(dirname "${BASH_SOURCE[0]}")/../ghc/plan.sh"

pkg_name=ghc88
pkg_origin=core
pkg_version=8.8.4
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="f0505e38b2235ff9f1090b51f44d6c8efd371068e5a6bb42a2a6d8b67b5ffc2d"
pkg_dirname="ghc-${pkg_version}"

pkg_include_dirs=("lib/ghc-${pkg_version}/include")
