pkg_name=clang
pkg_origin=core
pkg_version=5.0.1
pkg_license=('NCSA')
pkg_description="LLVM native C/C++/Objective-C compiler"
pkg_upstream_url="http://clang.llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="${pkg_name}-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz"
pkg_shasum="135f6c9b0cd2da1aff2250e065946258eb699777888df39ca5a5b4fe5e23d0ff"
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
  pushd "$unpack_dir" > /dev/null || exit
  # Per tar's help output:
  #
  #   --no-same-owner        extract files as yourself (default for ordinary users)
  #
  # The llvm package has some files owned by specific UIDs that we
  # can't be sure exist on the builder or target system.
  tar xf "$source_file" --strip 1 --no-same-owner
  popd > /dev/null || exit
}

do_build() {
  mkdir -p build
  cd build || exit
  cmake \
    -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" \
    -DCMAKE_BUILD_TYPE=Release \
    -G "Unix Makefiles" \
    ../
  make
}

do_check() {
  cd build || exit
  make test
}

do_install() {
  cd build || exit
  make install
}
