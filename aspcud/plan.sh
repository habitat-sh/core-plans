pkg_name=aspcud
pkg_origin=core
pkg_version="1.9.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv3+')
pkg_source="https://sourceforge.net/projects/potassco/files/aspcud/${pkg_version}/aspcud-${pkg_version}-source.tar.gz"
pkg_shasum="e0e917a9a6c5ff080a411ff25d1174e0d4118bb6759c3fe976e2e3cca15e5827"
pkg_dirname="${pkg_name}-${pkg_version}-source"
pkg_deps=(core/clingo core/gcc-libs core/re2c core/boost core/glibc)
pkg_build_deps=(core/cmake core/make core/gcc)
pkg_bin_dirs=(bin)

do_build() {
  mkdir build
  cmake -H./ \
    -Bbuild \
    -DBOOST_INCLUDEDIR="$(pkg_path_for boost)/include" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DGRINGO_LOC="$(pkg_path_for clingo)/bin/gringo" \
    -DCLASP_LOC="$(pkg_path_for clingo)/bin/clasp"
  make -C build
}

do_install() {
  make -C build install
}
