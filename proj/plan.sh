pkg_name=proj
pkg_origin=core
pkg_version=4.9.3
pkg_description="Cartographic Projections Library"
pkg_upstream_url=https://github.com/OSGeo/proj.4
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.osgeo.org/proj/proj-${pkg_version}.tar.gz
pkg_shasum=6984542fea333488de5c82eea58d699e4aff4b359200a9971537cd7e047185f7
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_deps=(
  core/glibc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
