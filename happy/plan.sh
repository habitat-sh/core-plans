pkg_name=happy
pkg_origin=core
pkg_version=1.19.9
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/happy/"
pkg_description="Happy is a parser generator for Haskell. Given a grammar specification in BNF, Happy generates Haskell code to parse the grammar. Happy works in a similar way to the yacc tool for C."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="3e81a3e813acca3aae52721c412cde18b7b7c71ecbacfaeaa5c2f4b35abf1d8d"

pkg_bin_dirs=(bin)

pkg_deps=(
  core/glibc
  core/gmp
  core/libffi
)

pkg_build_deps=(
  core/cabal-install
  core/ghc
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config/cache
  rm -rf /root/.cabal
}

do_build() {
  cabal sandbox init
  cabal update

  # Install dependencies
  cabal install --only-dependencies

  # Configure and Build
  cabal configure --prefix="$pkg_prefix"
  cabal build
}

do_install() {
  cabal copy
}
