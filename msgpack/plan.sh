pkg_name=msgpack
pkg_origin=core
pkg_version="2.1.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSL-1.0')
pkg_source="https://github.com/msgpack/${pkg_name}-c/releases/download/cpp-$pkg_version/${pkg_name}-$pkg_version.tar.gz"
pkg_shasum="fce702408f0d228a1b9dcab69590d6a94d3938f694b95c9e5e6249617e98d83f"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/cmake
  core/doxygen
  core/gcc
  core/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_description="MessagePack implementation for C and C++"
pkg_upstream_url="https://github.com/msgpack/msgpack-c"

do_build() {
  cmake . \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DDOXYGEN_EXECUTABLE="$(pkg_path_for doxygen)/bin/doxygen" \
    -DZLIB_INCLUDE_DIR="$(pkg_path_for zlib)/include" \
    -DZLIB_LIBRARY="$(pkg_path_for zlib)/libz.so"
  make
}
