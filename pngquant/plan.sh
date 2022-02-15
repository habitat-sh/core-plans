pkg_name=pngquant
pkg_origin=core
pkg_version=2.17.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_description="Lossy PNG compressor"
pkg_upstream_url="https://pngquant.org"
pkg_source="http://pngquant.org/pngquant-${pkg_version}-src.tar.gz"
pkg_shasum=a27cf0e64db499ccb3ddae9b36036e881f78293e46ec27a9e7a86a3802fcda66
pkg_deps=(
  core/coreutils
  core/libpng
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
  fix_interpreter "lib/configure" core/coreutils bin/env
  do_default_build
}

do_install() {
  cp COPYRIGHT "${pkg_prefix}"
  do_default_install
}
