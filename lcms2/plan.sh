pkg_name=lcms2
pkg_origin=core
pkg_version=2.12
pkg_description="Small-footprint color management engine, version 2"
pkg_upstream_url=http://www.littlecms.com
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source=http://downloads.sourceforge.net/sourceforge/lcms/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=2257531baedea1a47570e42b92634398afaef5ad5341562b497100048453dd45
pkg_deps=(
  core/glibc
  core/jbigkit
  core/libjpeg-turbo
  core/libtiff
  core/xz
  core/zlib
)
pkg_build_deps=(core/gcc core/make)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
