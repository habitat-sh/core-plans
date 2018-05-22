pkg_name=ghc710-bootstrap
pkg_origin=core
pkg_version=7.10.3
patched_version=7.10.3b
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskell.org/ghc/
pkg_description="The Glasgow Haskell Compiler - Binary Bootstrap"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${patched_version}-x86_64-deb8-linux.tar.xz
pkg_shasum=804c75c4635353bf987c1ca120b8531c7bb4957c5b84d29c7adc4894b6fd579d
pkg_dirname=ghc-${pkg_version}

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(lib/ghc-${pkg_version}/include)

pkg_deps=(
  core/perl
  core/gcc
  core/glibc
  core/gmp/6.1.0/20170513202112
  core/libffi
  core/ncurses5-compat-libs
)

pkg_build_deps=(
  core/patchelf
  core/make
)

ghc_patch_rpath() {
  RELATIVE_TO=$(dirname "$1")
  RELATIVE_PATHS=$( (for LIB_PATH in "${@:2}"; do echo "\$ORIGIN/$(realpath --relative-to="${RELATIVE_TO}" "${LIB_PATH}")"; done) | paste -sd ':' )
  patchelf --set-rpath "${LD_RUN_PATH}:${RELATIVE_PATHS}" "$1"
}
export -f ghc_patch_rpath

do_build() {
  build_line "Fixing interpreter for binaries:"

  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" {} \;

  export LD_LIBRARY_PATH="$LD_RUN_PATH"

  ./configure --prefix="${pkg_prefix}"
}

do_install() {
  local GHC_LIB_PATHS

  do_default_install

  pushd "${pkg_prefix}" > /dev/null

  GHC_LIB_PATHS=$(find . -name '*.so' -printf '%h\n' | uniq)

  build_line "Fixing rpath for binaries:"

  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -print \
    -exec bash -c 'ghc_patch_rpath $1 $2 ' _ "{}" "$GHC_LIB_PATHS" \;

  popd > /dev/null
}

do_strip() {
  return 0
}
