pkg_name=libimagequant
pkg_origin=core
pkg_version=2.16.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="Small, portable C library for high-quality conversion of RGBA images to 8-bit indexed-color (palette) images."
pkg_upstream_url="https://pngquant.org/lib"
pkg_source="https://github.com/ImageOptim/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=360f88a4a85546405e6bec36d403cedfda43e7b8b5ec140216b727a05cd3a8ac
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
