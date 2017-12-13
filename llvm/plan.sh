pkg_name=llvm
pkg_origin=core
pkg_version=3.9.1
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url="http://llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="${pkg_name}-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz"
pkg_shasum="1fd90354b9cf19232e8f168faf2220e79be555df3aa743242700879e8fd329ee"
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/zlib
)
pkg_build_deps=(
  core/cmake
  core/coreutils
  core/diffutils
  core/gcc
  core/ninja
  core/python2
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_unpack() {
  # The tarball's structure has `.src` as part of the base directory.
  # This reimplements a large portion of the default unpack, only to
  # add `--strip` to the tar command.
  # There may be some more awesome way to do this - I don't know that yet.
  build_line "Unpacking $pkg_filename to custom cache dir"
  local source_file=$HAB_CACHE_SRC_PATH/$pkg_filename
  local unpack_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}
  mkdir -p "$unpack_dir"
  pushd "$unpack_dir" > /dev/null
  # Per tar's help output:
  #
  #   --no-same-owner        extract files as yourself (default for ordinary users)
  #
  # The llvm package has some files owned by specific UIDs that we
  # can't be sure exist on the builder or target system.
  tar xf "$source_file" --strip 1 --no-same-owner
  popd > /dev/null

  # Download Clang frontend and place it in the correct place
  build_line "Unpacking Clang FrontEnd to custom cache dir"
  download_file http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz \
    cfe-${pkg_version}.src.tar.xz \
    e6c4cebb96dee827fa0470af313dff265af391cb6da8d429842ef208c8f25e63

  local clang_src_dir="$unpack_dir/tools/clang"
  mkdir -p "$clang_src_dir"
  pushd "$clang_src_dir" > /dev/null
  tar xf "$HAB_CACHE_SRC_PATH/cfe-${pkg_version}.src.tar.xz" --strip 1 --no-same-owner
  popd > /dev/null
}

do_build() {
  mkdir -p build
  cd build || exit
  cmake -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" -G "Ninja" ../
  ninja
}

do_check() {
  cd build || exit
  ninja check
}

do_install() {
  cd build || exit
  ninja install
}
