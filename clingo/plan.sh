pkg_name=clingo
pkg_origin=core
pkg_description="A grounder and solver for logic programs."
pkg_upstream_url="https://potassco.org/clingo"
pkg_version="5.2.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/potassco/clingo/archive/v${pkg_version}.tar.gz"
pkg_shasum="da1ef8142e75c5a6f23c9403b90d4f40b9f862969ba71e2aaee9a257d058bfcf"
pkg_deps=(core/gcc-libs core/glibc)
pkg_build_deps=(core/doxygen core/cmake core/make core/gcc)
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
    -DCLINGO_BUILD_APPS=YES
  make -C build
}

do_install() {
  make -C build install
}
