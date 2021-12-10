pkg_name=clingo
pkg_origin=core
pkg_description="A grounder and solver for logic programs."
pkg_upstream_url="https://potassco.org/clingo"
pkg_version=5.5.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/potassco/clingo/archive/v${pkg_version}.tar.gz"
pkg_shasum=b9cf2ba2001f8241b8b1d369b6f353e628582e2a00f13566e51c03c4dd61f67e
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
