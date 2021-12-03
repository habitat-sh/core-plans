pkg_name=cabal-install
pkg_origin=core
pkg_version=3.6.2.0
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/cabal/"
pkg_description="Command-line interface for Cabal and Hackage"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://downloads.haskell.org/~cabal/cabal-install-${pkg_version}/cabal-install-${pkg_version}.tar.gz"
pkg_shasum="a432a7853afe96c0fd80f434bd80274601331d8c46b628cd19a0d8e96212aaf1"

pkg_bin_dirs=(bin)

pkg_deps=(
  core/gcc-libs
  core/glibc
  core/gmp
  core/libffi
  core/zlib
)

pkg_build_deps=(
  core/curl
  core/ghc86
  core/sed
  core/which
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
  rm -rf /root/.cabal
}

do_build() {
  EXTRA_CONFIGURE_OPTS="--extra-include-dirs=$(pkg_path_for zlib)/include --extra-lib-dirs=$(pkg_path_for zlib)/lib" ./bootstrap.sh --sandbox
}

do_check() {
  # Validate the sandbox build
  .cabal-sandbox/bin/cabal update
  .cabal-sandbox/bin/cabal info cabal
}

do_install() {
  cp -f .cabal-sandbox/bin/cabal "$pkg_prefix/bin"
}
