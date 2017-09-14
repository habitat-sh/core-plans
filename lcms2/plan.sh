pkg_name=lcms2
pkg_origin=core
pkg_version=2.8
pkg_description="Small-footprint color management engine, version 2"
pkg_upstream_url=http://www.littlecms.com
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source=http://downloads.sourceforge.net/sourceforge/lcms/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=66d02b229d2ea9474e62c2b6cd6720fde946155cd1d0d2bffdab829790a0fb22
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
