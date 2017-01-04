pkg_name=ghc
pkg_origin=jarvus
pkg_version=8.0.1
pkg_source=http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-x86_64-deb7-linux.tar.xz
pkg_shasum=86a8109dfa4ec000e0048ed9d072c0d232affeb1069ca96b3995cb5cef2230a7
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/patchelf
)
pkg_deps=(
  core/glibc
  core/gmp
  core/perl
  core/gcc
  core/make
  core/libffi
  jarvus/ncurses5-compat-libs
)

ghc_patch_rpath() {
  RELATIVE_TO=$(dirname $1)
  RELATIVE_PATHS=$((for LIB_PATH in ${@:2}; do echo '$ORIGIN/'$(realpath --relative-to="$RELATIVE_TO" "$LIB_PATH"); done) | paste -sd ':')
  patchelf --set-rpath "${LD_RUN_PATH}:$RELATIVE_PATHS" $1
}
export -f ghc_patch_rpath

do_build() {
  build_line "Fixing interpreter for binaries:"

  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" {} \;

  export LD_LIBRARY_PATH="$LD_RUN_PATH"

  ./configure --prefix=${pkg_prefix}
}

do_install() {
  do_default_install

  pushd ${pkg_prefix} > /dev/null

  local GHC_LIB_PATHS=$(find . -name '*.so' -printf '%h\n' | uniq)

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
