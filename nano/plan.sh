pkg_name=nano
pkg_origin=core
pkg_version=4.9.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="GNU nano -- an enhanced clone of the Pico text editor."
pkg_upstream_url=https://www.nano-editor.org
pkg_source="https://www.nano-editor.org/dist/v4/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=6e3438f033a0ed07d3d74c30d0803cbda3d2366ba1601b7bbf9b16ac371f51b4
pkg_deps=(core/ncurses)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)

do_build() {
  do_default_build
  install -v -Dm644 COPYING "${pkg_prefix}/share/COPYING"
}
