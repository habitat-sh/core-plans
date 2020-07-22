pkg_name=nghttp2
pkg_origin=core
pkg_version=1.40.0
pkg_description="nghttp2 is an open source HTTP/2 C Library."
pkg_upstream_url=https://nghttp2.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=eb9d9046495a49dd40c7ef5d6c9907b51e5a6b320ea6e2add11eb8b52c982c47
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_deps=(
    core/glibc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
