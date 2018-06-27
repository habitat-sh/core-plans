pkg_name=pngquant
pkg_origin=core
pkg_version="2.11.7"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_source="https://github.com/kornelski/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum="0ca09a1f253b264e5aab8477b7f0e3cde51d9f88ed668b38ae057ced24076bda"
pkg_deps=(
  core/coreutils
)
pkg_build_deps=(
  core/make
  core/gcc
  core/libpng
  core/zlib
  core/pkg-config
  core/libimagequant
)
pkg_bin_dirs=(bin)
pkg_description="Lossy PNG compressor"
pkg_upstream_url="https://pngquant.org"

do_build() {
  fix_interpreter "configure" core/coreutils bin/env
  do_default_build
}

do_install() {
  cp COPYRIGHT "${pkg_prefix}"
  do_default_install
}
