pkg_name=shellcheck
hkg_name=ShellCheck
pkg_origin=core
pkg_version=0.5.0
pkg_license=('GPL-3')
pkg_upstream_url="http://www.shellcheck.net/"
pkg_description="ShellCheck is a GPLv3 tool that gives warnings and suggestions for bash/sh shell scripts"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz"
pkg_shasum="2b9430736f48de17a60c035546a6a969c14392521bec30119e1c869017d3307c"
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
  core/ghc
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
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
