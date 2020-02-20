pkg_name=imagemagick
pkg_origin=core
pkg_version=7.0.9-9
pkg_description="A software suite to create, edit, compose, or convert bitmap images."
pkg_upstream_url="http://imagemagick.org/"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.imagemagick.org/download/releases/ImageMagick-${pkg_version}.tar.xz"
pkg_shasum=257c9e11480aef95ea98d13495e3beb360d48c26fa8bd3da2d21c61907111d81
pkg_deps=(
  core/glibc
  core/zlib
  core/libpng
  core/xz
  core/gcc-libs
)
pkg_build_deps=(
  core/zlib
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
  core/glibc
  core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/ImageMagick-6)
pkg_lib_dirs=(lib)
pkg_dirname="ImageMagick-${pkg_version}"

do_build() {
    CC="gcc -std=gnu99" ./configure --prefix="${pkg_prefix}"
    make
}
