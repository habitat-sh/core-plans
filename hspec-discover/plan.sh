pkg_name=hspec-discover
pkg_origin=core
pkg_version=2.9.4
pkg_license=('MIT')
pkg_upstream_url="https://hspec.github.io/"
pkg_description="Automatically discover and run Hspec tests"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://hackage.haskell.org/package/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="db2e874baae9a90a957304a474ab805984023404c90b12789f762d319cf9c39b"

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

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
  cabal v1-sandbox init
  cabal v1-update

  # Install dependencies
  cabal v1-install --only-dependencies

  # Configure and Build
  cabal v1-configure --prefix="$pkg_prefix" \
    --disable-executable-dynamic \
    --disable-shared
  cabal v1-build
}

do_check() {
  cabal v1-test
}

do_install() {
  cabal v1-copy
}
