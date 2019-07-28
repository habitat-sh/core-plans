pkg_name=libimagequant
pkg_origin=core
pkg_version=2.12.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="Small, portable C library for high-quality conversion of RGBA images to 8-bit indexed-color (palette) images."
pkg_upstream_url="https://pngquant.org/lib"
pkg_source="https://github.com/ImageOptim/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=9dc07f3bf6efaf03241fd514e62108be484a373871e2e02c117e6efb49d26293
pkg_deps=(core/coreutils)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  fix_interpreter "configure" core/coreutils bin/env
  do_default_build
}
