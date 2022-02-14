pkg_name=cabal-install
pkg_origin=core
pkg_version=3.0.0.0
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/cabal/"
pkg_description="Command-line interface for Cabal and Hackage"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
#pkg_source="https://downloads.haskell.org/~cabal/cabal-install-${pkg_version}/cabal-install-${pkg_version}.tar.gz"
pkg_source=https://github.com/haskell/cabal/archive/refs/tags/cabal-install-v${pkg_version}.tar.gz
pkg_shasum=c0b26817a7b7c2907e45cb38235ce1157e732211880f62e92eaff4066202e674
pkg_dirname=cabal-cabal-install-v${pkg_version}

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
  core/which
  core/patch
)

do_clean() {
  do_default_clean

  # Strip any previous cabal config
  rm -rf /root/.cabal
}

do_prepare() {
	patch -p0 -l < "${PLAN_CONTEXT}/curl_error60.patch"
}

do_build() {
	cd ${HAB_CACHE_SRC_PATH}/${pkg_dirname}/cabal-install
	EXTRA_CONFIGURE_OPTS="--extra-include-dirs=$(pkg_path_for zlib)/include \
	       	--extra-lib-dirs=$(pkg_path_for zlib)/lib" ./bootstrap.sh --sandbox
}

do_check() {
	# Validate the sandbox build
	cabal-install/.cabal-sandbox/bin/cabal update
	cabal-install/.cabal-sandbox/bin/cabal info cabal
}

do_install() {
	cp -f cabal-install/.cabal-sandbox/bin/cabal "$pkg_prefix/bin"
}
