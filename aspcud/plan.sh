pkg_name=aspcud
pkg_origin=core
pkg_version="1.9.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="Aspcud is a solver for package dependencies"
pkg_upstream_url="https://potassco.org/aspcud/"
pkg_source="https://github.com/potassco/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="3645f08b079e1cc80e24cd2d7ae5172a52476d84e3ec5e6a6c0034492a6ea885"
pkg_deps=(
  core/clingo
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/boost
  core/cmake
  core/make
  core/gcc
  core/re2c
)
pkg_bin_dirs=(bin)

do_build() {
  mkdir build
  cmake -H./ \
    -Bbuild \
    -DBOOST_INCLUDEDIR="$(pkg_path_for boost)/include" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
    -DASPCUD_GRINGO_PATH="$(pkg_path_for clingo)/bin/gringo" \
    -DASPCUD_CLASP_PATH="$(pkg_path_for clingo)/bin/clasp"
  make -C build
}

do_install() {
  make -C build install
}
