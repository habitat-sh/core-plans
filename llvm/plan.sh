pkg_name=llvm
pkg_origin=core
pkg_version=3.6.2
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url=http://llvm.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename=${pkg_name}-${pkg_version}.src.tar.xz
pkg_source=http://llvm.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz
pkg_shasum=f60dc158bfda6822de167e87275848969f0558b3134892ff54fced87e4667b94
pkg_build_deps=(
  core/cmake
  core/coreutils
  core/diffutils
  core/gcc
  core/make
  core/python2
)
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/zlib
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
  tar xf "$source_file" --strip 1
  popd > /dev/null

  # Download Clang frontend and place it in the correct place
  build_line "Unpacking Clang FrontEnd to custom cache dir"
  download_file http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz \
    cfe-${pkg_version}.src.tar.xz \
    ae9180466a23acb426d12444d866b266ff2289b266064d362462e44f8d4699f3

  local clang_src_dir="$unpack_dir/tools/clang"
  mkdir -p "$clang_src_dir"
  pushd "$clang_src_dir" > /dev/null
  tar xf "$HAB_CACHE_SRC_PATH/cfe-${pkg_version}.src.tar.xz" --strip 1
  popd > /dev/null
}

do_build() {
  mkdir -p build
  cd build || exit
  cmake -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" -G "Unix Makefiles" ../
  make
}

do_check() {
  cd build || exit
  make check
}

do_install() {
  cd build || exit
  make install
}
