pkg_name=prometheus-cpp
pkg_origin=core
pkg_version=0.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://github.com/jupp0r/prometheus-cpp"
pkg_description="Prometheus Client Library for Modern C++"
pkg_license=('MIT')
pkg_source="https://github.com/jupp0r/prometheus-cpp.git"
pkg_shasum=noshasum
pkg_deps=(
)
pkg_build_deps=(
  core/cacerts
  core/cmake
  core/gcc
  core/git
  core/glibc
  core/make
  core/zlib
)

pkg_include_dirs=(include)
pkg_lib_dirs=(lib64)

BUILDDIR="_build"

do_download() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO

  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"

  # removing any previous git repo under the same package name that was downloaded
  rm -rf "$REPO_PATH"

  git clone "$pkg_source" "$REPO_PATH"

  pushd "$REPO_PATH"
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
  ZLIB_DIR="$(pkg_path_for core/zlib)"

  pushd "${BUILDDIR}"
  cmake \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
    -DZLIB_INCLUDE_DIR="$ZLIB_DIR/include" \
    -DZLIB_LIBRARY="$ZLIB_DIR/lib/libz.so" \
    ..

  make
}

do_check() {
  pushd "${BUILDDIR}"
  ctest -V
}

do_install() {
  pushd "${BUILDDIR}"
  make install
}
