pkg_name=nghttp2
pkg_origin=core
pkg_version=1.31.0
pkg_description="nghttp2 is an open source HTTP/2 C Library."
pkg_upstream_url=https://nghttp2.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source=https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=6a2d02c441cf8d4279aea3c98d22763f8464808c3955db5c308291fe59d17cab
pkg_dirname=${pkg_name}-${pkg_version}
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
