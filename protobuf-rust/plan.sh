pkg_name=protobuf-rust
pkg_origin=core
pkg_version=1.7.5
pkg_license=('BSD')
pkg_bin_dirs=(bin)
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://github.com/stepancheg/rust-protobuf"
pkg_description="Rust implementation of Google protocol buffers"
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/rust
  core/gcc
)

do_build() {
  cargo install protobuf --root "${pkg_prefix}" --vers "${pkg_version}" -j"$(nproc)" --verbose
}

do_install() {
  return 0
}

do_download() {
  return 0
}
