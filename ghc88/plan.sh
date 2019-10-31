source "$(dirname "${BASH_SOURCE[0]}")/../ghc/plan.sh"

pkg_name=ghc88
pkg_origin=core
pkg_version=8.8.1
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="908a83d9b814da74585de9d39687189e6260ec3848131f9d9236cab8a123721a"
pkg_dirname="ghc-${pkg_version}"

pkg_include_dirs=("lib/ghc-${pkg_version}/include")
