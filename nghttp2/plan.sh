pkg_name=nghttp2
pkg_origin=core
pkg_version=1.46.0
pkg_description="nghttp2 is an open source HTTP/2 C Library."
pkg_upstream_url=https://nghttp2.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=4b6d11c85f2638531d1327fe1ed28c1e386144e8841176c04153ed32a4878208
pkg_build_deps=(
  core/make
  core/gcc
  core/python38
)
pkg_deps=(
    core/glibc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
