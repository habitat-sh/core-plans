pkg_name=leveldb
pkg_origin=core
pkg_description="LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values."
pkg_upstream_url="https://github.com/google/leveldb"
pkg_version="1.23"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source="https://github.com/google/${pkg_name}.git"
pkg_deps=(
  core/snappy
  core/glibc
  core/gcc-libs
  core/sqlite
)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/git
)
pkg_lib_dirs=(lib64)
pkg_include_dirs=(include)

do_download() {
  if [ ! -d "${SRC_PATH}" ]; then
    git clone --recurse-submodules "${pkg_source}" "${SRC_PATH}"
  fi
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_clean() {
  rm -rf "${SRC_PATH}/build"
}

do_build() {
  mkdir -p build
  pushd build &>/dev/null || exit 1
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" ..
    cmake --build .
  popd &>/dev/null || exit 1
}

do_install() {
  pushd build &>/dev/null || exit 1
    cmake --install .
  popd &>/dev/null || exit 1
}
