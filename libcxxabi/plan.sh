pkg_name=libcxxabi
pkg_version=5.0.2
pkg_origin=core
pkg_license=('NCSA')
pkg_description="A new implementation of the C++ standard library, targeting C++11"
pkg_upstream_url=http://libcxxabi.llvm.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename=${pkg_name}-${pkg_version}.src.tar.xz
pkg_source=http://llvm.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz
pkg_shasum=1bbf9bf2c92a4d627dd7bb7a15166acecae924b19898dc0573244f9d533a978a
pkg_build_deps=(
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

# libcxxabi requires headers from libcxx, and libcxx requires the libcxxabi libraries
#   leaving us with a chicken and an egg.
# Since libcxxabi only requires headers and not a post-build artifact, it's safer to
#    build libcxxabi first, and have it be a dependency of libcxx. The implementation
#    of do_download and do_unpack below allows us to pull in the necessary headers in
#    order to build libcxxabi.
do_download() {
  do_default_download

  build_line "Downloading libcxx source"
  download_file http://llvm.org/releases/${pkg_version}/libcxx-${pkg_version}.src.tar.xz \
    libcxx-${pkg_version}.src.tar.xz \
    6edf88e913175536e1182058753fff2365e388e017a9ec7427feb9929c52e298
}

do_unpack() {
  mkdir -p "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxx"
  pushd "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxx"
  tar xf "$HAB_CACHE_SRC_PATH/libcxx-${pkg_version}.src.tar.xz" --strip 1
  popd

  mkdir -p "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxxabi"
  pushd "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxxabi"
  tar xf "$HAB_CACHE_SRC_PATH/libcxxabi-${pkg_version}.src.tar.xz" --strip 1
  popd
}

do_prepare() {
  export BUILDDIR="_build"
  mkdir -p "${BUILDDIR}"
}

do_build() {
  pushd "${BUILDDIR}"
  cmake \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
    -DCMAKE_C_FLAGS="$CFLAGS" \
    -DLIBCXXABI_LIBCXX_PATH=../libcxx \
    ../libcxxabi
  make
  popd
}

# This is here for reference only.  make check-libcxxabi requires libraries from libcxx in order
#   to run the tests. This makes the chicken-egg problem harder to solve, requiring a feature like
#   package splits, or combining libcxx and libcxxabi into a single package.
do_check() {
  pushd "${BUILDDIR}"
  make check-libcxxabi
  popd
}

do_install() {
  pushd "${BUILDDIR}"
  make install-libcxxabi
  install -Dm644 ../libcxxabi/include/cxxabi.h "${pkg_prefix}/include/cxxabi.h"
  install -Dm644 ../libcxxabi/include/__cxxabi_config.h "${pkg_prefix}/include/__cxxabi_config.h"
  popd
}
