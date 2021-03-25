pkg_name=benchmark
pkg_origin=core
pkg_version=1.5.2
pkg_description="Google's microbenchmark support library"
pkg_upstream_url=https://github.com/google/benchmark
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/google/benchmark/archive/v${pkg_version}.tar.gz"
pkg_filename="v${pkg_version}.tar.gz"
pkg_shasum=0db8066b8476c5cc8393bfa95e4198b59d6bf3156e6c589872730be1083c16dd
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
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_begin() {
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_SEPARATOR=";"
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_TYPE="aggregate"
}

do_setup_environment() {
  set_buildtime_env BUILD_DIR "_build"

  # this allows cmake users to utilize `CMAKE_FIND_ROOT_PATH` to find various cmake configs
  push_runtime_env CMAKE_FIND_ROOT_PATH "${pkg_prefix}/lib/cmake/benchmark"
}

do_prepare() {
  mkdir -p "${BUILD_DIR}"
}

do_build() {
  GTEST_DIR="$(pkg_path_for core/googletest)"

  pushd "${BUILD_DIR}" || exit 1

  cmake \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DBENCHMARK_ENABLE_TESTING="${DO_CHECK}" \
    -DBENCHMARK_ENABLE_GTEST_TESTS="${DO_CHECK}" \
    -DGTEST_LIBRARY="${GTEST_DIR}/lib64/libgtest.a" \
    -DGTEST_MAIN_LIBRARY="${GTEST_DIR}/lib64/libgtest_main.a" \
    -DGTEST_INCLUDE_DIR="${GTEST_DIR}/include" \
    -DCMAKE_BUILD_TYPE="RELEASE" \
    ..
  make -j"$(nproc --ignore=1)"
  popd || exit 1
}

do_check() {
  pushd "${BUILD_DIR}" || exit 1
  make test -j"$(nproc --ignore=1)"
  popd || exit 1
}

do_install() {
  pushd "${BUILD_DIR}" || exit 1
  make install
  popd || exit 1
}
