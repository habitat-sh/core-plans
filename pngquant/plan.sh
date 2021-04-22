pkg_name=pngquant
pkg_origin=core
pkg_version=2.13.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_description="Lossy PNG compressor"
pkg_upstream_url="https://pngquant.org"
pkg_source="http://pngquant.org/pngquant-${pkg_version}-src.tar.gz"
pkg_shasum=4b911a11aa0c35d364b608c917d13002126185c8c314ba4aa706b62fd6a95a7a
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
