pkg_name=nghttp2
pkg_origin=core
pkg_version=1.24.0
pkg_description="nghttp2 is an open source HTTP/2 C Library."
pkg_upstream_url=https://nghttp2.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source=https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=5058da99c94764ff39f4a7046b9c8f0b6bafa10ec2fc096945a5d9d693654840
pkg_dirname=${pkg_name}-${pkg_version}
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
