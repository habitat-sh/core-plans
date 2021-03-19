pkg_name=openjpeg
pkg_origin=core
pkg_version=2.4.0
pkg_description="An open source JPEG 2000 codec"
pkg_upstream_url=http://www.openjpeg.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source="https://github.com/uclouvain/openjpeg/archive/v${pkg_version}.tar.gz"
pkg_shasum=521b3f250fe0789aed78ab7855794d4be0629dfccf768273657efe1d0c4dafed
pkg_deps=(
  core/lcms2
  core/libpng
  core/libtiff
  core/zlib
)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  mkdir -p build
}

do_build() {
  pushd build > /dev/null
  cmake .. \
    -DLCMS2_INCLUDE_DIR="$(pkg_path_for core/lcms2)/include" \
    -DLCMS2_LIBRARY="$(pkg_path_for core/lcms2)/lib/liblcms2.so" \
    -DPNG_PNG_INCLUDE_DIR="$(pkg_path_for core/libpng)/include" \
    -DPNG_LIBRARY="$(pkg_path_for core/libpng)/lib/libpng.so" \
    -DTIFF_INCLUDE_DIR="$(pkg_path_for core/libtiff)/include" \
    -DTIFF_LIBRARY="$(pkg_path_for core/libtiff)/lib/libtiff.so" \
    -DZLIB_INCLUDE_DIR="$(pkg_path_for core/zlib)/include" \
    -DZLIB_LIBRARY="$(pkg_path_for core/zlib)/lib/libz.so" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix"
  make
  popd > /dev/null
}

do_install() {
  pushd build > /dev/null
  make install
  popd > /dev/null
}
