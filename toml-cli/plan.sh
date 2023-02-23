program="toml-cli"

pkg_name="toml-cli"
pkg_origin="core"
pkg_version="0.2.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A simple CLI for editing and querying TOML files."
pkg_upstream_url="https://github.com/gnprice/toml-cli"
pkg_license=('MIT')
pkg_source="https://github.com/gnprice/toml-cli/archive/refs/tags/v${pkg_version}.tar.gz"
pkg_shasum="913f104612b0e549090e1cf77a7a49a12fa286af7e720dd46265bcc554b8f73a"
pkg_dirname="${program}-${pkg_version}"

pkg_build_deps=(
	core/rust
	core/gcc
)
pkg_bin_dirs=(bin)

do_prepare() {
	# Add flags to build a static binary with the C runtime linked in
	export RUSTFLAGS='-C target-feature=+crt-static'
	build_line "Setting RUSTFLAGS=${RUSTFLAGS}"
}

do_build() {
	cargo build \
		--release \
		--target="${TARGET_ARCH:-${pkg_target%%-*}}-unknown-linux-gnu"
}

do_install() {
	cargo install \
		--path . \
		--root "${pkg_prefix}" \
		--target="${TARGET_ARCH:-${pkg_target%%-*}}-unknown-linux-gnu"
}

