pkg_name="toml-cli"
pkg_origin="core"
pkg_version="0.2.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A simple CLI for editing and querying TOML files."
pkg_upstream_url="https://github.com/gnprice/toml-cli"
pkg_license=('MIT')
pkg_source="https://github.com/gnprice/toml-cli/releases/download/v${pkg_version}/toml-${pkg_version}-x86_64-linux.tar.gz"
pkg_dirname="toml-${pkg_version}-x86_64-linux"
pkg_shasum="ba12ae6b53fc593a9dcae3d6ef5d50f0382b3f77708603dc237e9145ba7988fc"

pkg_build_deps=()
pkg_bin_dirs=(bin)

do_build() {
	return 0
}

do_install() {
	cp toml "$pkg_prefix"/bin
}
