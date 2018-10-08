# shellcheck disable=SC2148,SC1091
source ../ghc/plan.sh

pkg_name=ghc86
pkg_origin=core
pkg_version=8.6.1
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="2c25c26d1e5c47c7cbb2a1d8e6456524033e7a71409184dd3125e3fc5a3c7036"
pkg_dirname="ghc-${pkg_version}"

pkg_include_dirs=(lib/ghc-${pkg_version}/include)
