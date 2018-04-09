pkg_name=fixesproto
pkg_origin=core
pkg_version=5.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X.Org Protocol Headers: fixesproto"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="ba2f3f31246bdd3f2a0acf8bd3b09ba99cab965c7fb2c2c92b7dc72870e424ce"
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
  core/util-macros
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
