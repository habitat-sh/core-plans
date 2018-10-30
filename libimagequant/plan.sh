pkg_name=libimagequant
pkg_origin=core
pkg_version="2.12.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_source="https://github.com/ImageOptim/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum="23ccecb4898ec17474914cfd2fbc4684425f7fd249117f2f1e3f3ba0bf8159e6"
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
