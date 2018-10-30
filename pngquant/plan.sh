pkg_name=pngquant
pkg_origin=core
pkg_version="2.12.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_source="https://github.com/kornelski/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum="5edf7c5bffd07e5d28fcc6d4d94a187c30b532c52ac986b3e45aff3dce0567dc"
pkg_deps=(
  core/coreutils
  core/libpng
  core/libimagequant
  core/zlib
)
pkg_build_deps=(
  core/make
  core/gcc
  core/pkg-config
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
