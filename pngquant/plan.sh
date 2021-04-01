pkg_name=pngquant
pkg_origin=core
pkg_version=2.14.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_description="Lossy PNG compressor"
pkg_upstream_url="https://pngquant.org"
pkg_source="https://github.com/kornelski/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=5b2e29d61f548b18b0dd37156a49f87625123250577815add666e473fd1ca1af
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
