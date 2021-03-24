pkg_name=pngquant
pkg_origin=core
pkg_version=2.14.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_description="Lossy PNG compressor"
pkg_upstream_url="https://pngquant.org"
pkg_source="https://github.com/kornelski/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=e695e8e8d6ce2265c7eb5f23f7ac38aeeae822671dda20723ee41379a7b8c184
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
