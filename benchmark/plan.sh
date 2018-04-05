pkg_name=benchmark
pkg_origin=core
pkg_version=1.4.0
pkg_description="Google's microbenchmark support library"
pkg_upstream_url=https://github.com/google/benchmark
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/google/benchmark/archive/v${pkg_version}.tar.gz"
pkg_filename="v${pkg_version}.tar.gz"
pkg_shasum=616f252f37d61b15037e3c2ef956905baf9c9eecfeab400cb3ad25bae714e214
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/binutils
  core/cmake
  core/make
  core/gcc
  core/git
  core/googletest
  core/googlemock
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

BUILDDIR="build"

do_prepare() {
  mkdir -p "$BUILDDIR"
}

do_build() {
  GTEST_DIR="$(pkg_path_for core/googletest)"

  cd "$BUILDDIR" || exit
  cmake \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_BUILD_TYPE="RELEASE" \
    -DGTEST_LIBRARY="$GTEST_DIR/lib/libgtest.a" \
    -DGTEST_MAIN_LIBRARY="$GTEST_DIR/lib/libgtest_main.a" \
    -DGTEST_INCLUDE_DIR="$GTEST_DIR/include" \
    ..
  make
}

do_check() {
  cd "$BUILDDIR" || exit
  make test
}

do_install() {
  cd "$BUILDDIR" || exit
  make install
}
