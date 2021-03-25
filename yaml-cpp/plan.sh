pkg_name=yaml-cpp
pkg_origin=core
pkg_version=0.6.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="A YAML parser and emitter in C++"
pkg_upstream_url="https://github.com/jbeder/yaml-cpp"
pkg_source="https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-${pkg_version}.tar.gz"
pkg_shasum="7e4325fb4a539e0fdc25da54d14c35d9ad5c525f3ad59308582f4d7fbf720680"
pkg_dirname="yaml-cpp-yaml-cpp-${pkg_version}"
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/cmake
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include/yaml-cpp include/gtest include/gmock)

do_build() {
  cmake -DCMAKE_INSTALL_PREFIX:PATH="${pkg_prefix}" \
    -DCMAKE_CXX_FLAGS:STRING="${CXXFLAGS} ${CPPFLAGS}" \
    -DCMAKE_C_FLAGS:STRING="${CFLAGS} ${CPPFLAGS}" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo .
}

do_install() {
  make install
}
