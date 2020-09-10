pkg_name=gdal
pkg_origin=core
pkg_version=2.4.0
pkg_description="GDAL is a translator library for raster and vector geospatial data formats"
pkg_upstream_url=http://www.gdal.org/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.osgeo.org/gdal/${pkg_version}/gdal-${pkg_version}.tar.gz
pkg_shasum=a568cf3dc7bb203ae12a48e1eb2a42302cded499ef6eccaf9e8f09187d8ce75a
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
  core/patchelf
)
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)


do_install() {
  do_default_install

  build_line "Patching ELF binaries:"
  find "${pkg_prefix}/lib" -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-sharedlib; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
}
