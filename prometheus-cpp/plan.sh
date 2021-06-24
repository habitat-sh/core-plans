pkg_name=prometheus-cpp
pkg_origin=core
pkg_version=0.12.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://github.com/jupp0r/prometheus-cpp"
pkg_description="Prometheus Client Library for Modern C++"
pkg_license=('MIT')
pkg_source="https://github.com/jupp0r/prometheus-cpp.git"
pkg_shasum=noshasum
pkg_deps=()
pkg_build_deps=(
  core/glibc
  core/benchmark
  core/cacerts
  core/openssl
  core/curl
  core/cmake
  core/ninja
  core/gcc
  core/git
  core/pkg-config
)

pkg_include_dirs=(include)
pkg_lib_dirs=(lib64)

do_begin() {
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_SEPARATOR=";"
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_TYPE="aggregate"
}

do_setup_environment() {
  set_buildtime_env BUILDDIR "_build"

  # this allows cmake users to utilize `CMAKE_FIND_ROOT_PATH` to find various cmake configs
  push_runtime_env CMAKE_FIND_ROOT_PATH "${pkg_prefix}/lib64/cmake/prometheus-cpp"
}

do_download() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO

  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"

  # removing any previous git repo under the same package name that was downloaded
  rm -rf "$REPO_PATH"

  git clone "$pkg_source" "$REPO_PATH"

  pushd "$REPO_PATH" || exit 1
  git checkout "tags/v${pkg_version}"
  git submodule init
  git submodule update
}

do_clean() {
  return 0
}

do_unpack() {
  return 0
}

do_verify() {
  return 0
}

do_prepare() {
  mkdir -p "${BUILDDIR}"
}

do_build() {
  _BENCHMARK_PATH="$(pkg_path_for core/benchmark)"
  _CURL_PATH="$(pkg_path_for core/curl)"

  pushd "${BUILDDIR}" || exit 1
  cmake \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
    -DCMAKE_FIND_ROOT_PATH="${CMAKE_FIND_ROOT_PATH}" \
    -DENABLE_COMPRESSION="OFF" \
    -DENABLE_TESTING="${DO_CHECK}" \
    -DGoogleBenchmark_LIBRARY="${_BENCHMARK_PATH}/lib/libbenchmark.a" \
    -DGoogleBenchmark_INCLUDE_DIR="${_BENCHMARK_PATH}/include" \
    -DCURL_LIBRARY="${_CURL_PATH}/lib/libcurl.so" \
    -DCURL_INCLUDE_DIR="${_CURL_PATH}/include" \
    -G Ninja \
    ..
  ninja
  popd || exit 1
}

do_check() {
  pushd "${BUILDDIR}" || exit 1
  LD_LIBRARY_PATH="$(pkg_path_for core/glibc)/lib:$(pkg_path_for core/gcc)/lib" ctest -V
  popd || exit 1
}

do_install() {
  pushd "${BUILDDIR}" || exit 1
  ninja install
  popd || exit 1
}
