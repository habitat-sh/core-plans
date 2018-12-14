pkg_name=msgpack
pkg_origin=core
pkg_version="2.1.5"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="MessagePack implementation for C and C++"
pkg_upstream_url="https://github.com/msgpack/msgpack-c"
pkg_license=('BSL-1.0')
pkg_source="https://github.com/msgpack/${pkg_name}-c/releases/download/cpp-$pkg_version/${pkg_name}-$pkg_version.tar.gz"
pkg_shasum="6126375af9b204611b9d9f154929f4f747e4599e6ae8443b337915dcf2899d2b"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/cmake
  core/doxygen
  core/gcc7
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
