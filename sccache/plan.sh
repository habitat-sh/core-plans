pkg_name=sccache
pkg_origin=core
pkg_version=0.2.15
pkg_license=('Apache-2.0')
pkg_upstream_url="https://github.com/mozilla/sccache"
pkg_description="sccache is ccache with cloud storage"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/mozilla/sccache/archive/v${pkg_version}.tar.gz"
pkg_shasum=7dbe71012f9b0b57d8475de6b36a9a3b4802e44a135e886f32c5ad1b0eb506e0
pkg_bin_dirs=(bin)
pkg_deps=(
  # Due to an update with glibc moving libpthread.so.0 contents into libc, the build
  # will fail on glibc 2.32 and newer with 'relocation error: [..]-script-build: symbol pthread_getattr_np
  #   version GLIBC_2.2.5 not defined in file libpthread.so.0 with link time reference'
  # Pin this to glibc 2.29, and gcc-libs 9.1.0 (dependency conflicts) to prevent this until the underlying
  # dep is updated (log v0.4.11)
  core/glibc/2.29
  core/gcc-libs/9.1.0
  core/openssl/1.0.2w/20210514035028
)
pkg_build_deps=(
  core/rust
  core/pkg-config
)
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  cargo build \
    --features="all" \
    --release
}

do_install() {
  install -v -D "${CACHE_PATH}/target/release/sccache" "${pkg_prefix}/bin/sccache"
}
