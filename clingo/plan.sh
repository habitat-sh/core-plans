pkg_name=clingo
pkg_origin=core
pkg_description="A grounder and solver for logic programs."
pkg_upstream_url="https://potassco.org/clingo"
pkg_version="5.4.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/potassco/clingo/archive/v${pkg_version}.tar.gz"
pkg_shasum=ac6606388abfe2482167ce8fd4eb0737ef6abeeb35a9d3ac3016c6f715bfee02
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

do_setup_environment() {
  export LDFLAGS="$LDFLAGS -Wl,--copy-dt-needed-entries"
}

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
