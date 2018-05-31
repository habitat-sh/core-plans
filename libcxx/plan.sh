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
  core/clang
  core/cmake
  core/gcc
  core/llvm
  core/make
)
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/libcxxabi
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_unpack() {
  mkdir -p "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxx"
  pushd "$HAB_CACHE_SRC_PATH/${pkg_dirname}/libcxx"
  tar xf "$HAB_CACHE_SRC_PATH/$pkg_filename" --strip 1
  popd
}

do_prepare() {
  export BUILDDIR="_build"
  mkdir -p "${BUILDDIR}"
}

do_build() {
  LLVM_PATH="$(pkg_path_for core/llvm)"

  pushd "${BUILDDIR}"
  cmake \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DLLVM_PATH="${LLVM_PATH}" \
    -DLIBCXX_CXX_ABI=libcxxabi \
    ../libcxx
  make
  popd
}


do_install() {
  pushd "${BUILDDIR}"
  make install-libcxx
  popd
}
