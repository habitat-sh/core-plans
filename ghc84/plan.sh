# shellcheck disable=SC2148,SC1091
source ../ghc/plan.sh

pkg_name=ghc84
pkg_origin=core
pkg_version=8.4.3
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="ae47afda985830de8811243255aa3744dfb9207cb980af74393298b2b62160d6"
pkg_dirname="ghc-${pkg_version}"

pkg_include_dirs=(lib/ghc-${pkg_version}/include)
