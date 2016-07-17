pkg_origin=core
pkg_name=htop
pkg_version=2.0.1
pkg_description="This is htop, an interactive process viewer for Unix systems. It is a text-mode application (for console or X terminals) and requires ncurses."
pkg_upstream_url=http://hisham.hm/htop/
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://hisham.hm/htop/releases/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=f410626dfaf6b70fdf73cd7bb33cae768869707028d847fed94a978e974f5666
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/ncurses)
pkg_bin_dirs=(bin)

do_check() {
  make test
}
