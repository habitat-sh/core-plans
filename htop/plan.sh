pkg_origin=core
pkg_name=htop
pkg_version=3.0.2
pkg_description="This is htop, an interactive process viewer for Unix systems. It is a text-mode application (for console or X terminals) and requires ncurses."
pkg_upstream_url="https://bintray.com/htop/"
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://bintray.com/htop/source/download_file?file_path=htop-${pkg_version}.tar.gz"
pkg_shasum="6471d9505daca5c64073fc37dbab4d012ca4fc6a7040a925dad4a7553e3349c4"

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
