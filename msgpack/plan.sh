pkg_name=msgpack
pkg_origin=core
pkg_version="3.3.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="MessagePack implementation for C and C++"
pkg_upstream_url="https://github.com/msgpack/msgpack-c"
pkg_license=('BSL-1.0')
pkg_source="https://github.com/msgpack/${pkg_name}-c/releases/download/cpp-$pkg_version/${pkg_name}-$pkg_version.tar.gz"
pkg_shasum=6e114d12a5ddb8cb11f669f83f32246e484a8addd0ce93f274996f1941c1f07b
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/cmake
  core/doxygen
  core/gcc
  core/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  cmake . \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DDOXYGEN_EXECUTABLE="$(pkg_path_for doxygen)/bin/doxygen" \
    -DZLIB_INCLUDE_DIR="$(pkg_path_for zlib)/include" \
    -DZLIB_LIBRARY="$(pkg_path_for zlib)/libz.so"
  make
}
