pkg_name=nghttp2
pkg_origin=core
pkg_version=1.34.0
pkg_description="nghttp2 is an open source HTTP/2 C Library."
pkg_upstream_url=https://nghttp2.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=8889399ddd38aa0405f6e84f1c050a292286089441686b8a9c5e937de4f5b61d
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
