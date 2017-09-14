pkg_name=openjpeg
pkg_origin=core
pkg_version=2.1.2
pkg_description="An open source JPEG 2000 codec"
pkg_upstream_url=http://www.openjpeg.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source=https://github.com/uclouvain/openjpeg/archive/v${pkg_version}.tar.gz
pkg_shasum=4ce77b6ef538ef090d9bde1d5eeff8b3069ab56c4906f083475517c2c023dfa7

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
