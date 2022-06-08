pkg_name=ghc
pkg_origin=core
pkg_version=8.10.7
pkg_license=('BSD-3-Clause')
pkg_upstream_url="https://www.haskell.org/ghc/"
pkg_description="The Glasgow Haskell Compiler"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-src.tar.xz"
pkg_shasum=e3eef6229ce9908dfe1ea41436befb0455fefb1932559e860ad4c606b0d03c9d

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=("lib/ghc-${pkg_version}/include")
pkg_interpreters=(bin/runhaskell bin/runghc)

pkg_build_deps=(
  core/alex
  core/coreutils
  core/binutils
  core/diffutils
  core/ghc86
  core/happy
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
}

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-system-libffi \
    --with-ffi-includes="$(pkg_path_for libffi)/include" \
    --with-ffi-libraries="$(pkg_path_for libffi)/lib" \
    --with-curses-includes="$(pkg_path_for ncurses)/include" \
    --with-curses-libraries="$(pkg_path_for ncurses)/lib" \
    --with-gmp-includes="$(pkg_path_for gmp)/include" \
    --with-gmp-libraries="$(pkg_path_for gmp)/lib"

  #make -j"$(nproc)"
  make
}
