pkg_name=prometheus-cpp
pkg_origin=core
git_sha=357e040a35204cee9d3ca48332aead9d56776f6e
pkg_version="0.3-${git_sha:0:7}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://github.com/jupp0r/prometheus-cpp
pkg_description="Prometheus Client Library for Modern C++"
pkg_licenses=('MIT')
pkg_source="https://github.com/jupp0r/prometheus-cpp.git"
pkg_shasum=noshasum
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/protobuf
  core/zlib
)
pkg_build_deps=(
  core/cacerts
  core/gcc
  core/cmake
  core/make
  core/git
  core/telegraf
)

pkg_include_dirs=(include)
pkg_lib_dirs=(lib64)

BUILDDIR="_build"

do_download() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO

  cd "$HAB_CACHE_SRC_PATH" > /dev/null || exit

  # removing any previous git repo under the same package name that was downloaded
  rm -rf "$pkg_name"

  git clone "$pkg_source" "$pkg_name"

  cd "$pkg_name" > /dev/null || exit
  git reset --hard "$git_sha"
  # git checkout "tags/v$pkg_version"
  git submodule init
  git submodule update
}

do_unpack() {
  cd "$HAB_CACHE_SRC_PATH" > /dev/null || exit
  mv "$pkg_name" "$pkg_dirname"
}

do_verify() {
  return 0
}

do_prepare() {
  mkdir -p "${BUILDDIR}"
}

do_build() {
  PROTOBUF_DIR="$(pkg_path_for core/protobuf)"
  ZLIB_DIR="$(pkg_path_for core/zlib)"

  cd "${BUILDDIR}" || exit
  cmake \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DProtobuf_INCLUDE_DIR="$PROTOBUF_DIR/include" \
    -DProtobuf_LIBRARY="$PROTOBUF_DIR/lib/libprotobuf.so" \
    -DZLIB_INCLUDE_DIR="$ZLIB_DIR/include" \
    -DZLIB_LIBRARY="$ZLIB_DIR/lib/libz.so" \
    ..

  make
}

do_check() {
  cd "${BUILDDIR}" || exit
  ctest -V
}

do_install() {
  cd "${BUILDDIR}" || exit
  make install
}
