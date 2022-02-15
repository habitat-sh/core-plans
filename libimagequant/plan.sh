pkg_name=libimagequant
pkg_origin=core
pkg_version=2.17.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="Small, portable C library for high-quality conversion of RGBA images to 8-bit indexed-color (palette) images."
pkg_upstream_url="https://pngquant.org/lib"
pkg_source="https://github.com/ImageOptim/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=9f6cc50182be4d2ece75118aa0b0fd3e9bbad06e94fd6b9eb3a4c08129c2dd26
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
