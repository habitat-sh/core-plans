pkg_origin=core
pkg_name=lynx
pkg_version=2.8.9rel.1
pkg_description="Lynx is the text web browser."
pkg_upstream_url=http://lynx.browser.org/
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://invisible-mirror.net/archives/$pkg_name/tarballs/$pkg_name${pkg_version}.tar.gz"
pkg_shasum=a46e4167b8f02c066d2fe2eafcc5603367be0e3fe2e59e9fc4eb016f306afc8e
pkg_dirname="$pkg_name${pkg_version}"
pkg_deps=(
  core/glibc
  core/ncurses
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)

do_check() {
  make test
}
