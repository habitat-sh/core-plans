pkg_origin=core
pkg_name=protobuf-c
pkg_version=1.3.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source="https://github.com/protobuf-c/protobuf-c/releases/download/v${pkg_version}/protobuf-c-${pkg_version}.tar.gz"
pkg_shasum=51472d3a191d6d7b425e32b612e477c06f73fe23e07f6a6a839b11808e9d2267
pkg_deps=(core/gcc-libs core/protobuf-cpp core/zlib)
pkg_build_deps=(core/gcc core/make core/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/protobuf-c/protobuf-c
pkg_description="Protocol Buffers implementation in C"

do_build () {
  ./configure --prefix="$pkg_prefix"
  make
}

do_check () {
  make check
}
