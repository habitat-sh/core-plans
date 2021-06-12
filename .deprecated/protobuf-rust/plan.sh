pkg_name=protobuf-rust
pkg_origin=core
pkg_version=1.7.4
pkg_license=('BSD')
pkg_bin_dirs=(bin)
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://github.com/stepancheg/rust-protobuf"
pkg_description="Rust implementation of Google protocol buffers"
pkg_deps=(
  # Due to an update with glibc moving libpthread.so.0 contents into libc, the build
  # will fail on glibc 2.32 and newer with 'relocation error: [..]-script-build: symbol pthread_sigmask
  #   version GLIBC_2.2.5 not defined in file libpthread.so.0 with link time reference'
  # Pin this to glibc 2.29, and gcc-libs 9.1.0 (dependency conflicts) to prevent this until the underlying
  # dep is updated (protobuf v1.7.5)
  core/glibc/2.29
  core/gcc-libs/9.1.0
)
pkg_build_deps=(
  core/rust
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
