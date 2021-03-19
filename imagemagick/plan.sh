pkg_name=imagemagick
pkg_origin=core
pkg_version=7.0.11-3
pkg_description="A software suite to create, edit, compose, or convert bitmap images."
pkg_upstream_url="http://imagemagick.org/"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/ImageMagick/ImageMagick/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum=2912cfffc03bd20bc32623b3bf4b68cee3d037d705eabbdd3463c36c8e4834a8
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
