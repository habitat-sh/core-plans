pkg_name=pngquant
pkg_origin=core
pkg_version=2.12.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_description="Lossy PNG compressor"
pkg_upstream_url="https://pngquant.org"
pkg_source="https://github.com/kornelski/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=9d2c5197b21c42931623fb3e6064b91c133bfb52c84428ee1bf9b84712c9b83c
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

do_build() {
  fix_interpreter "configure" core/coreutils bin/env
  do_default_build
}

do_install() {
  cp COPYRIGHT "${pkg_prefix}"
  do_default_install
}
