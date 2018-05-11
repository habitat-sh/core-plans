pkg_name=yaml-cpp
pkg_origin=core
pkg_version=0.6.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="A YAML parser and emitter in C++"
pkg_upstream_url="https://github.com/jbeder/yaml-cpp"
pkg_source="https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-0.6.2.tar.gz"
pkg_shasum="e4d8560e163c3d875fd5d9e5542b5fd5bec810febdcba61481fe5fc4e6b1fd05"
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
