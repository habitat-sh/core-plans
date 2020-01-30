pkg_name=nano
pkg_origin=core
pkg_version=4.7
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="GNU nano -- an enhanced clone of the Pico text editor."
pkg_upstream_url=https://www.nano-editor.org
pkg_source="https://www.nano-editor.org/dist/v4/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=58c0e197de5339ca3cad3ef42b65626d612ddb0b270e730f02e6ab3785c736f5
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
