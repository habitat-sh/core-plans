pkg_name=cmake
pkg_origin=core
_base_version=3.16
pkg_version=${_base_version}.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('BSD-3-Clause')
pkg_description="CMake is an open-source, cross-platform family of tools designed to build, test and package software"
pkg_upstream_url="https://cmake.org/"
pkg_source="https://cmake.org/files/v${_base_version}/cmake-${pkg_version}.tar.gz"
pkg_shasum=6da56556c63cab6e9a3e1656e8763ed4a841ac9859fefb63cbe79472e67e8c5f
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/curl
  core/zlib
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/make
  core/gcc
  core/patch
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_prepare() {
  # This disables a test that incorrectly detects that a file has write access
  patch -p0 < "$PLAN_CONTEXT"/patches/000-disable_test_file_access.patch
  # This disables two tests that will always fail in a Habitat build environment
  patch -p0 < "$PLAN_CONTEXT"/patches/001-disable-failing-bundleutlities-tests.patch
}

do_build() {
  ZLIB=$(pkg_path_for core/zlib)
  ZLIB_LIB="${ZLIB}/lib"
  ZLIB_INCLUDE="${ZLIB}/include"
  CURL=$(pkg_path_for core/curl)
  CURL_LIB="${CURL}/lib"
  CURL_INCLUDE="${CURL}/include"

  ./bootstrap --parallel="$(nproc)" --system-curl -- \
    -DZLIB_LIBRARY:FILEPATH="${ZLIB_LIB}/libz.so" -DZLIB_INCLUDE_DIR:PATH="${ZLIB_INCLUDE}" \
    -DCURL_LIBRARY:FILEPATH="${CURL_LIB}/libcurl.so"  -DCURL_INCLUDE_DIR:PATH="${CURL_INCLUDE}"

  ./configure --prefix="${pkg_prefix}"
  make -j "$(nproc)"
}

do_check() {
  make test
}
