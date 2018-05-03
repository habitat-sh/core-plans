pkg_name=libcxx
pkg_origin=core
pkg_version=5.0.1
pkg_license=('NCSA')
pkg_description="A new implementation of the C++ standard library, targeting C++11"
pkg_upstream_url=http://libcxx.llvm.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename=${pkg_name}-${pkg_version}.src.tar.xz
pkg_source=http://llvm.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz
pkg_shasum=fa8f99dd2bde109daa3276d529851a3bce5718d46ce1c5d0806f46caa3e57c00
pkg_build_deps=(
  core/binutils
  core/clang
  core/cmake
  core/gcc
  core/llvm
  core/make
)
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

BUILDDIR="_build"

do_download() {
  do_default_download

  build_line "Downloading libcxxabi"
  download_file http://llvm.org/releases/${pkg_version}/libcxxabi-${pkg_version}.src.tar.xz \
    libcxxabi-${pkg_version}.src.tar.xz \
    5a25152cb7f21e3c223ad36a1022faeb8a5ac27c9e75936a5ae2d3ac48f6e854
}

do_unpack() {
  # build_line "Copy llvm src"
  # cp -R "$(pkg_path_for core/llvm)/src/" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"

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
  # Without these links, the clang linker fails. I not been able to find any
  # workaround for this. The library paths do not impact the search paths for these files
  # clang_path=$(dirname "$(find "$(pkg_path_for core/clang)/lib/clang" -type d -name include)")
  # export clang_path
  #
  # build_line "clang_path: $clang_path"
  #
  # ln -sf "$(pkg_path_for glibc)/lib/crtn.o"  "$clang_path/crtn.o"
  # ln -sf "$(pkg_path_for glibc)/lib/crt1.o"  "$clang_path/crt1.o"
  # ln -sf "$(pkg_path_for glibc)/lib/crti.o"  "$clang_path/crti.o"
  # ln -sf "$(pkg_path_for gcc)/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/crtbegin.o"  "$clang_path/crtbegin.o"
  #
  # CC="$(pkg_path_for core/clang)/bin/clang"
  # export CC
  # CXX="$(pkg_path_for core/clang)/bin/clang++"
  # export CXX

  mkdir -p "${BUILDDIR}"
}

do_build() {
  LLVM_PATH="$(pkg_path_for core/llvm)"

  pushd "${BUILDDIR}"
  cmake \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DLLVM_PATH="${LLVM_PATH}" \
    -DLIBCXX_CXX_ABI=libcxxabi \
    -DLIBCXX_CXX_ABI_INCLUDE_PATHS="${HAB_CACHE_SRC_PATH}/${pkg_dirname}/libcxxabi/include" \
    ../libcxx

  make
  popd
  #
  # pushd libcxxabi
  # cmake \
  #   -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
  #   -DCMAKE_CXX_FLAGS="$CXXFLAGS --gcc-toolchain=$(pkg_path_for gcc)" \
  #   -DCMAKE_C_FLAGS="$CFLAGS --gcc-toolchain=$(pkg_path_for gcc)" \
  #   -DLIBCXXABI_LIBCXX_PATH=../libcxx \
  #   .
  # make
  # popd
  #
  # cmake \
  #   -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
  #   -DCMAKE_CXX_FLAGS="$CXXFLAGS --gcc-toolchain=$(pkg_path_for gcc)" \
  #   -DCMAKE_C_FLAGS="$CFLAGS --gcc-toolchain=$(pkg_path_for gcc)" \
  #   -DLIBCXX_CXX_ABI=libcxxabi \
  #   -DLIBCXX_CXX_ABI_LIBRARY_PATH=libcxxabi/lib \
  #   -DLIBCXX_CXX_ABI_INCLUDE_PATHS=libcxxabi/include \
  #   libcxx
  # make
}

do_check() {
  pushd "${BUILDDIR}"
  make check-libcxx # check-cxx check-cxxabi
  popd
}

do_install() {
  pushd "${BUILDDIR}"
  make install-libcxx
  popd
}

# do_end() {
#   rm "$clang_path/crtn.o"
#   rm "$clang_path/crt1.o"
#   rm "$clang_path/crti.o"
# }
