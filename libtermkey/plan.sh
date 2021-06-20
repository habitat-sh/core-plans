pkg_name=libtermkey
pkg_origin=core
pkg_version="0.22"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="http://www.leonerd.org.uk/code/$pkg_name/$pkg_name-${pkg_version}.tar.gz"
pkg_shasum="6945bd3c4aaa83da83d80a045c5563da4edd7d0374c62c0d35aec09eb3014600"
pkg_deps=(
  core/glibc
  core/ncurses
)
pkg_build_deps=(
  core/gcc
  core/libtool
  core/make
  core/pkg-config
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_description="This library allows easy processing of keyboard entry from terminal-based programs."
pkg_upstream_url="http://www.leonerd.org.uk/code/libtermkey/"

do_build() {
  make PREFIX="$pkg_prefix"
}

do_install() {
  make install PREFIX="$pkg_prefix"
}
