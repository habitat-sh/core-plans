pkg_name=libcxx
pkg_origin=core
pkg_version=3.9.0
pkg_license=('NCSA')
pkg_description="A new implementation of the C++ standard library, targeting C++11"
pkg_upstream_url=http://libcxx.llvm.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename=${pkg_name}-${pkg_version}.src.tar.xz
pkg_source=http://llvm.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz
pkg_shasum=d0b38d51365c6322f5666a2a8105785f2e114430858de4c25a86b49f227f5b06
pkg_build_deps=(
  core/cmake
  core/llvm
  core/make
)
pkg_deps=(
  core/gcc
  core/glibc
  core/util-linux
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_download() {
  do_default_download

  build_line "Downloading libcxxabi"
  download_file http://llvm.org/releases/${pkg_version}/libcxxabi-${pkg_version}.src.tar.xz \
    libcxxabi-${pkg_version}.src.tar.xz \
    b037a92717856882e05df57221e087d7d595a2ae9f170f7bc1a23ec7a92c8019
}

do_unpack() {
  mkdir -p "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxx"
  pushd "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxx"
  tar xf "$HAB_CACHE_SRC_PATH/$pkg_filename" --strip 1
  popd

  mkdir -p "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxxabi"
  pushd "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxxabi"
  tar xf "$HAB_CACHE_SRC_PATH/libcxxabi-${pkg_version}.src.tar.xz" --strip 1
  popd
}

do_prepare() {
  do_default_prepare

  # Without these links, the clang linker fails. I not been able to find any
  # workaround for this. The library paths do not impact the search paths for these files
  clang_path=$(dirname "$(find "$(pkg_path_for llvm)/lib/clang" -type d -name include)")
  export clang_path

  ln -sf "$(pkg_path_for glibc)/lib/crtn.o"  "$clang_path/crtn.o"
  ln -sf "$(pkg_path_for glibc)/lib/crt1.o"  "$clang_path/crt1.o"
  ln -sf "$(pkg_path_for glibc)/lib/crti.o"  "$clang_path/crti.o"

  CC="$(pkg_path_for llvm)/bin/clang"
  export CC
  CXX="$(pkg_path_for llvm)/bin/clang++"
  export CXX
}

do_build() {
  pushd libcxxabi
  cmake \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DCMAKE_CXX_FLAGS="$CXXFLAGS --gcc-toolchain=$(pkg_path_for gcc)" \
    -DCMAKE_C_FLAGS="$CFLAGS --gcc-toolchain=$(pkg_path_for gcc)" \
    -DLIBCXXABI_LIBCXX_PATH=../libcxx \
    .
  make
  popd

  cmake \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DCMAKE_CXX_FLAGS="$CXXFLAGS --gcc-toolchain=$(pkg_path_for gcc)" \
    -DCMAKE_C_FLAGS="$CFLAGS --gcc-toolchain=$(pkg_path_for gcc)" \
    -DLIBCXX_CXX_ABI=libcxxabi \
    -DLIBCXX_CXX_ABI_LIBRARY_PATH=libcxxabi/lib \
    -DLIBCXX_CXX_ABI_INCLUDE_PATHS=libcxxabi/include \
    libcxx
  make
}

do_install() {
  pushd libcxxabi
  make install-libcxxabi
  popd

  make install-libcxx
}

do_end() {
  rm "$clang_path/crtn.o"
  rm "$clang_path/crt1.o"
  rm "$clang_path/crti.o"
}
