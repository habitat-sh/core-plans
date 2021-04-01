pkg_name=fd
pkg_origin=core
pkg_version=7.5.0
pkg_license=('MIT' 'Apache-2.0')
pkg_bin_dirs=(bin)
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://github.com/sharkdp/fd"
pkg_source="https://github.com/sharkdp/fd/archive/v${pkg_version}.tar.gz"
pkg_shasum=8a78ca24323c832cf205c1fce8276fc25ae90371531c32e155301937986ea713
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_description="fd is a simple, fast and user-friendly alternative to find"
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/rust
)

do_build() {
  cargo build -j"$(nproc)" --release --verbose
}

do_check() {
  cargo test
}

do_install() {
  cargo install --root "${pkg_prefix}" --path "${CACHE_PATH}" --verbose
}
