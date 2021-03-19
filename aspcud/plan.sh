pkg_name=aspcud
pkg_origin=core
pkg_version=1.9.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_description="Aspcud is a solver for package dependencies"
pkg_upstream_url=https://potassco.org/aspcud/
pkg_source="https://github.com/potassco/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=8c420a34e549d015d71059d9f1e1b06955429dd070d20b191e7374f26c7f1ecc
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
