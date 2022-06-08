# shellcheck disable=SC2148,SC1091
source ../ghc/plan.sh

pkg_name=ghc710
pkg_origin=core
pkg_version=7.10.3
patched_version=7.10.3b
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${patched_version}-src.tar.xz"
pkg_shasum="06c6c20077dc3cf7ea3f40126b2128ce5ab144e1fa66fd1c05ae1ade3dfaa8e5"
pkg_dirname="ghc-${pkg_version}"

pkg_include_dirs=(lib/ghc-${pkg_version}/include)

pkg_deps=(
  core/gcc
  core/glibc
  core/gmp
  core/libedit
  core/ncurses
  core/perl
)

pkg_build_deps=(
  core/binutils
  core/diffutils
  core/ghc710-bootstrap
  core/libffi
  core/make
  core/patch
  core/sed
)

do_build() {
  # Setting this path is only necessary when building from a binary bootstrap
  LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for gmp)/lib:$(pkg_path_for ncurses)/lib:$(pkg_path_for libffi)/lib"
  export LD_LIBRARY_PATH

  # Using embedded libffi for ghc 7.10 as linking fails with the hab version
  # https://mail.haskell.org/pipermail/ghc-devs/2017-October/014883.html seems to be related
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-curses-includes="$(pkg_path_for ncurses)/include" \
    --with-curses-libraries="$(pkg_path_for ncurses)/lib" \
    --with-gmp-includes="$(pkg_path_for gmp)/include" \
    --with-gmp-libraries="$(pkg_path_for gmp)/lib"

  make
}
