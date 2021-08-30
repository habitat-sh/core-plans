pkg_name=xcb-proto
pkg_origin=core
pkg_version=1.12
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 client library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/xcb/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="5922aba4c664ab7899a29d92ea91a87aa4c1fc7eb5ee550325c3216c480a4906"
pkg_build_deps=(
  core/gcc
  core/libxml2
  core/make
  core/python2
)
pkg_pconfig_dirs=(lib/pkgconfig)

do_setup_environment() {
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python2.7/site-packages"
}
