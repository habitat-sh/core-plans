pkg_name=clingo
pkg_origin=core
pkg_description="A grounder and solver for logic programs."
pkg_upstream_url="https://potassco.org/clingo"
pkg_version="5.4.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/potassco/clingo/archive/v${pkg_version}.tar.gz"
pkg_shasum="1d9ac88cbcf36ea8ce5f4b88b3154166f52faeef561c85b9985392e3c88151bd"
pkg_build_deps=(
  core/cmake
  core/doxygen
  core/gcc
  core/make
)
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/python
  core/lua
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
  mkdir build
  cmake -H./ \
    -Bbuild \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCLINGO_MANAGE_RPATH=YES \
    -DCLINGO_BUILD_APPS=YES \
    -DLUA_LIBRARIES="$(pkg_path_for core/lua)/lib/liblua.a" \
    -DLUA_INCLUDE_DIR="$(pkg_path_for core/lua)/include"
  make -C build
}

do_install() {
  make -C build install
}
