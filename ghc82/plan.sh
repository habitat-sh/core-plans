pkg_name=ghc82
pkg_origin=core
pkg_version=8.2.2
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum="bb8ec3634aa132d09faa270bbd604b82dfa61f04855655af6f9d14a9eedc05fc"
pkg_dirname="ghc-${pkg_version}"

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(lib/ghc-${pkg_version}/include)

pkg_deps=(
  core/gcc
  core/glibc
  core/gmp
  core/libedit
  core/libffi
  core/ncurses
  core/perl
)

pkg_build_deps=(
  core/binutils
  core/diffutils
  core/ghc82-bootstrap
  core/make
  core/patch
  core/sed
)

do_prepare() {
  do_default_prepare

  # Explicitly set linker so we aren't tied to the default studio linker
  LD="$(pkg_path_for binutils)/bin/ld"
  export LD
  build_line "Updating LD=$LD"
  # Set library path
  LIBRARY_PATH="${LIBRARY_PATH}:${LD_RUN_PATH}"
  export LIBRARY_PATH
  build_line "Updating LIBRARY_PATH=$LIBRARY_PATH"

  cp mk/build.mk.sample mk/build.mk
  sed -i '1iBuildFlavour = perf' mk/build.mk
}

do_build() {
  # Setting this path is only necessary when building from a binary bootstrap
  LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for gmp)/lib:$(pkg_path_for ncurses)/lib:$(pkg_path_for libffi)/lib"
  export LD_LIBRARY_PATH

  libffi_include=$(find "$(pkg_path_for libffi)/lib/" -name "libffi-*.*.*")

  if [ -z "${libffi_include}" ]; then
    echo "libffi_include not found, exiting"
    exit 1
  fi

  ./configure \
    --prefix="${pkg_prefix}" \
    --with-system-libffi \
    --with-ffi-includes="${libffi_include}/include" \
    --with-ffi-libraries="$(pkg_path_for libffi)/lib" \
    --with-curses-includes="$(pkg_path_for ncurses)/include" \
    --with-curses-libraries="$(pkg_path_for ncurses)/lib" \
    --with-gmp-includes="$(pkg_path_for gmp)/include" \
    --with-gmp-libraries="$(pkg_path_for gmp)/lib"

  make
}
