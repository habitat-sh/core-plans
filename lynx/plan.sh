pkg_origin=core
pkg_name=lynx
pkg_version=2.8.8
pkg_description="Lynx is the text web browser."
pkg_upstream_url=http://lynx.browser.org/
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://invisible-mirror.net/archives/$pkg_name/tarballs/$pkg_name${pkg_version}rel.2.tar.gz"
pkg_shasum=234c9dc77d4c4594ad6216d7df4d49eae3019a3880e602f39721b35b97fbc408
pkg_dirname="$pkg_name${pkg_version//./-}"
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
