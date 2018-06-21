pkg_name=libimagequant
pkg_origin=core
pkg_version="2.12.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_source="https://github.com/ImageOptim/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum="7035eb281bc9a49cf36db8db807b713d03a0ffe8c5abfbb17a9ea8a038f21d5e"
pkg_deps=(core/coreutils)
pkg_build_deps=(core/make core/gcc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_description="Small, portable C library for high-quality conversion of RGBA images to 8-bit indexed-color (palette) images."
pkg_upstream_url="https://pngquant.org/lib"

do_build() {
  fix_interpreter "configure" core/coreutils bin/env
  do_default_build
}
