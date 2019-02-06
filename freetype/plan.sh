pkg_name=freetype
pkg_version=2.9.1
pkg_origin=core
pkg_description="A software library to render fonts"
pkg_upstream_url="https://www.freetype.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('FreeType' 'GPL-2.0')
pkg_source=http://download.savannah.gnu.org/releases/freetype/${pkg_name}-${pkg_version}.tar.bz2
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=db8d87ea720ea9d5edc5388fc7a0497bb11ba9fe972245e0f7f4c7e8b1e1e84d
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
)
pkg_deps=(
  core/bzip2
  core/glibc
  core/libpng
  core/zlib
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
