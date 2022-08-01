pkg_name=protobuf2
pkg_origin=core
pkg_version=2.6.1
pkg_description="Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data."
pkg_upstream_url="https://developers.google.com/protocol-buffers/"
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/google/protobuf/releases/download/v${pkg_version}/protobuf-${pkg_version}.tar.bz2
pkg_shasum=ee445612d544d885ae240ffbcbf9267faa9f593b7b101f21d58beceb92661910
pkg_dirname="protobuf-${pkg_version}"

pkg_deps=(
    core/gcc
    core/zlib
)
pkg_build_deps=(core/make)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
