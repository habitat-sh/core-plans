pkg_name=libtiff
pkg_origin=core
pkg_version=4.0.10
pkg_description="Library for reading and writting files in the Tag Image File Format (TIFF)"
pkg_upstream_url="http://www.remotesensing.org/libtiff/"
pkg_license=('libtiff')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.osgeo.org/libtiff/tiff-${pkg_version}.tar.gz"
pkg_shasum=2c52d11ccaf767457db0c46795d9c7d1a8d8f76f68b0b800a3dfe45786b996e4
pkg_deps=(core/glibc core/zlib core/libjpeg-turbo core/xz core/jbigkit)
pkg_build_deps=(core/gcc core/make core/diffutils core/file)
pkg_dirname="tiff-${pkg_version}"
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_prepare() {
  _file_path="$(pkg_path_for file)/bin/file"
  sed -e "s#/usr/bin/file#${_file_path}#g" -i configure
}

do_check() {
    make check
}
