pkg_name=cabal-install
pkg_origin=core
pkg_version=3.0.0.0
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/cabal/"
pkg_description="Command-line interface for Cabal and Hackage"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://downloads.haskell.org/~cabal/cabal-install-${pkg_version}/cabal-install-${pkg_version}.tar.gz"
pkg_shasum="a432a7853afe96c0fd80f434bd80274601331d8c46b628cd19a0d8e96212aaf1"

pkg_filename="Cabal-v${pkg_version}.tar.gz"
pkg_dirname="cabal-Cabal-v${pkg_version}"
pkg_source="https://github.com/haskell/cabal/archive/refs/tags/${pkg_filename}"
pkg_shasum="11394a247dc8d8f236ced27eb7dce7907bd2e2ff98f73b60d6f84011d158bdb2"
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
  core/ghc
  core/sed
  core/which
  core/python
  core/coreutils
  core/patch
)

do_before() {
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_file=true
  fi
}

do_prepare() {
  patch -p1 < "${PLAN_CONTEXT}"/patches/000-ghc-8-10-4.patch
}

do_build() {
  ./bootstrap/bootstrap.py \
    --deps ./bootstrap/linux-8.10.4.json
}

do_check() {
  # Validate the sandbox build
  .cabal-sandbox/bin/cabal update
  .cabal-sandbox/bin/cabal info cabal
}

do_install() {
  cp -f .cabal-sandbox/bin/cabal "$pkg_prefix/bin"
}

do_end() {
  if [[ -n "${_clean_file}" ]]; then
    rm -fv /usr/bin/env
  fi
}
