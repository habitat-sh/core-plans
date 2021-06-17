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
  core/glibc
  core/gcc-libs
  core/openssl
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
