source "$(dirname "${BASH_SOURCE[0]}")/../ghc84/plan.sh"

pkg_name=ghc
pkg_origin=core
pkg_version=8.6.3
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="9f9e37b7971935d88ba80426c36af14b1e0b3ec1d9c860f44a4391771bc07f23"

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(lib/ghc-${pkg_version}/include)
pkg_interpreters=(bin/runhaskell bin/runghc)

pkg_build_deps=(
  core/coreutils
  core/binutils
  core/diffutils
  core/ghc82
  core/make
  core/patch
  core/sed
)

pkg_deps=(
  core/gcc
  core/glibc
  core/gmp
  core/libedit
  core/libffi
  core/ncurses
  core/perl
)
