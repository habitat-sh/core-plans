pkg_name=clingo
pkg_origin=core
pkg_description="A grounder and solver for logic programs."
pkg_upstream_url="https://potassco.org/clingo"
pkg_version="5.3.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/potassco/clingo/archive/v${pkg_version}.tar.gz"
pkg_shasum="b0d406d2809352caef7fccf69e8864d55e81ee84f4888b0744894977f703f976"
pkg_build_deps=(
  core/cmake
  core/doxygen
  core/gcc
  core/make
)
pkg_deps=(
  core/gcc-libs
  core/glibc
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
    -DCLINGO_BUILD_APPS=YES
  make -C build
}

do_install() {
  make -C build install
}
