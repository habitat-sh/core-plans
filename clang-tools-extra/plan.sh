pkg_name=clang-tools-extra
pkg_origin=core
pkg_version=7.1.0
pkg_license=('NCSA')
pkg_description="Clang Tools are standalone command line (and potentially GUI) tools designed for use by C++ developers who are already using and enjoying Clang as their compiler. These tools provide developer-oriented functionality such as fast syntax checking, automatic formatting, refactoring, etc."
pkg_upstream_url="https://clang.llvm.org/docs/ClangTools.html#extra-clang-tools"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="${pkg_name}-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz"
pkg_shasum="1ce0042c48ecea839ce67b87e9739cf18e7a5c2b3b9a36d177d00979609b6451"
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/zlib
)
pkg_build_deps=(
  core/llvm
  core/cmake
  core/coreutils
  core/diffutils
  core/gcc
  core/make
  core/python2
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_unpack() {
  # The tarball's structure has `.src` as part of the base directory.
  # This reimplements a large portion of the default unpack, only to
  # add `--strip` to the tar command.
  # There may be some more awesome way to do this - I don't know that yet.
  local source_file=$HAB_CACHE_SRC_PATH/$pkg_filename
  local unpack_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}

  # Download Clang frontend and place it in the correct place
  build_line "Unpacking Clang FrontEnd Source to custom cache dir"
  download_file http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz \
    cfe-${pkg_version}.src.tar.xz \
    135f6c9b0cd2da1aff2250e065946258eb699777888df39ca5a5b4fe5e23d0ff

  local clang_src_dir="$unpack_dir"
  mkdir -p "$clang_src_dir"
  pushd "$clang_src_dir" > /dev/null || exit
  tar xf "$HAB_CACHE_SRC_PATH/cfe-${pkg_version}.src.tar.xz" --strip 1 --no-same-owner
  popd > /dev/null || exit

  # Unpack Clang-Tools-Extra and place it in the correct place
  build_line "Unpacking Clang-Tools-Extra to custom cache dir"
  local clang_tools_extra_src_dir="$unpack_dir/tools/extra"
  mkdir -p "$clang_tools_extra_src_dir"
  pushd "$clang_tools_extra_src_dir" > /dev/null || exit
  tar xf "$source_file" --strip 1 --no-same-owner
  popd > /dev/null || exit
}

do_build() {
  mkdir -p build
  cd build || exit
  cmake -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../
  cd tools/extra || exit
  make -j"$(nproc)"
}

do_check() {
  cd build/tools/extra || exit
  make test
}

do_install() {
  cd build/tools/extra || exit
  make install
}
