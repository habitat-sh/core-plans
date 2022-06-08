pkg_name=imagemagick
pkg_origin=core
pkg_version=7.1.0-17
pkg_description="A software suite to create, edit, compose, or convert bitmap images."
pkg_upstream_url="http://imagemagick.org/"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/ImageMagick/ImageMagick/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum=3f0228b21dca520d394b9f1fac96b3a0e3bcd09005cc389ae8504190ac63260b
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
pkg_include_dirs=(include/ImageMagick-7)
pkg_lib_dirs=(lib)
pkg_dirname="ImageMagick-${pkg_version}"

do_build() {
    CC="gcc -std=gnu99" ./configure --prefix="${pkg_prefix}"
    make
}
