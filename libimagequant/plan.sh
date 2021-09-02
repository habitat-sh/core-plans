pkg_name=libimagequant
pkg_origin=core
pkg_version=2.14.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="Small, portable C library for high-quality conversion of RGBA images to 8-bit indexed-color (palette) images."
pkg_upstream_url="https://pngquant.org/lib"
pkg_source="https://github.com/ImageOptim/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=b5fa27da1f3cf3e8255dd02778bb6a51dc71ce9f99a4fc930ea69b83200a7c74
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
