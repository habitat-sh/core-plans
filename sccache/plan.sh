pkg_name=sccache
pkg_origin=core
pkg_version=0.2.2
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/mozilla/sccache/archive/${pkg_version}.tar.gz
pkg_shasum="6a741ebf41bc8cee97ded3b823f464038af65c55de474b53efb1e24b5d234c36"
pkg_bin_dirs=(bin)
pkg_upstream_url="https://github.com/mozilla/sccache"
pkg_description="sccache is ccache with cloud storage"
pkg_deps=(core/glibc core/gcc-libs core/openssl)
pkg_build_deps=(core/rust core/gcc core/pkg-config core/openssl core/make)

do_build() {
  cargo build --release
}

do_install() {
  cargo install --root "${pkg_prefix}"
}
