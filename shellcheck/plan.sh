pkg_name=shellcheck
hkg_name=ShellCheck
pkg_origin=core
pkg_version=0.8.0
pkg_license=('GPL-3')
pkg_upstream_url="http://www.shellcheck.net/"
pkg_description="ShellCheck is a GPLv3 tool that gives warnings and suggestions for bash/sh shell scripts"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz"
pkg_shasum="62080e8a59174b12ecd2d753af3e6b9fed977e6f5f7301cde027a54aee555416"
pkg_dirname="${hkg_name}-${pkg_version}"

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

pkg_deps=(
  core/glibc
  core/gmp
  core/libffi
)

pkg_build_deps=(
  core/cabal-install
  core/ghc86
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
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
