pkg_name=aspcud
pkg_origin=core
pkg_version=1.9.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_description="Aspcud is a solver for package dependencies"
pkg_upstream_url=https://potassco.org/aspcud/
pkg_source="https://github.com/potassco/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=9cd3a9490d377163d87b16fa1a10cc7254bc2dbb9f60e846961ac8233f3835cf
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
  core/patch
)
pkg_bin_dirs=(bin)

do_build() {
  patch -p0 < "$PLAN_CONTEXT/non-const-MINSIGSTKSZ-fix.patch"
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
