pkg_origin=core
pkg_name=htop
pkg_version=3.0.5
pkg_description="This is htop, an interactive process viewer for Unix systems. It is a text-mode application (for console or X terminals) and requires ncurses."
pkg_upstream_url="https://bintray.com/htop/"
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://bintray.com/htop/source/download_file?file_path=htop-${pkg_version}.tar.gz"
pkg_shasum="19535f8f01ac08be2df880c93c9cedfc50fa92320d48e3ef92a30b6edc4d1917"

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
