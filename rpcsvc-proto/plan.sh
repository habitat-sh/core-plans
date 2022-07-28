pkg_name=rpcsvc-proto
pkg_origin=core
pkg_version=1.4.2
pkg_description="This package contains rpcsvc proto.x files from glibc, \
       which are missing in libtirpc. Additional it contains rpcgen, \
       which is needed to create header files and sources from protocol files."
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("BSD-3-Clause")
pkg_source=https://github.com/thkukuk/rpcsvc-proto/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=678851b9f7ddf4410d2859c12016b65a6dd1a0728d478f18aeb54d165352f17c
pkg_upstream_url=https://github.com/thkukuk/rpcsvc-proto

pkg_deps=(
  core/gcc
)

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure \
  --prefix="$pkg_prefix"
  make
}

do_install() {
  make install
}
