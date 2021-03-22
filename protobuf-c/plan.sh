pkg_origin=core
pkg_name=protobuf-c
pkg_version=1.3.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source="https://github.com/protobuf-c/protobuf-c/releases/download/v${pkg_version}/protobuf-c-${pkg_version}.tar.gz"
pkg_upstream_url=https://github.com/protobuf-c/protobuf-c
pkg_description="Protocol Buffers implementation in C"
pkg_shasum=03325278aca4c1781ed7c48c0e94320d3e57e8dcda54873a0bdaa463a091a1c1
pkg_deps=(
  core/gcc-libs
  core/protobuf-cpp
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_check() {
  make check
}
