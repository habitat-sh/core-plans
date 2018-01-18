pkg_name=sccache
pkg_origin=core
pkg_version=0.2.4
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/mozilla/sccache/archive/${pkg_version}.tar.gz
pkg_shasum="82d8d553a0cf2752e71266523f9aac30c1b5a12fa6b1faea8c7c6e1ec9827371"
pkg_bin_dirs=(bin)
pkg_upstream_url="https://github.com/mozilla/sccache"
pkg_description="sccache is ccache with cloud storage"
pkg_deps=(core/glibc core/gcc-libs core/openssl)
pkg_build_deps=(core/rust core/gcc core/pkg-config core/openssl core/make)
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  cargo build --release
}

do_install() {
  cargo install --root "${pkg_prefix}"
}
