pkg_name=pngquant
pkg_origin=core
pkg_version="2.12.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_source="https://github.com/kornelski/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum="53721387e1aa1729ccf20ff8faaf2587ebe4d03faaa0f6235a63070e08105967"
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
