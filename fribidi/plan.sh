pkg_name=fribidi
pkg_origin=core
pkg_version="1.0.11"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1 License')
pkg_upstream_url="https://github.com/fribidi/fribidi/"
pkg_source="https://github.com/fribidi/fribidi/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="30f93e9c63ee627d1a2cedcf59ac34d45bf30240982f99e44c6e015466b4e73d"
pkg_description="A command-line interface to the libfribidi library and can be used to convert a logical string to visual output."
pkg_deps=(
)
pkg_build_deps=(
	core/meson
	core/gcc
	core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
	meson _build -Dprefix="$pkg_prefix" --buildtype=release
	ninja -C _build
}
do_install() {
  ninja -C _build install
}
