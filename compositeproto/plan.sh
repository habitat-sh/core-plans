pkg_name=compositeproto
pkg_origin=core
pkg_version=0.4.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 Composite extension header files"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="049359f0be0b2b984a8149c966dd04e8c58e6eade2a4a309cf1126635ccd0cfc"
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
