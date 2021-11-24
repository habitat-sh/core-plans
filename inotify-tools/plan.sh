pkg_origin=core
pkg_name=inotify-tools
pkg_version=3.21.9.6
pkg_description="inotify-tools is a C library and a set of command-line programs for Linux providing a simple interface to inotify. These programs can be used to monitor and act upon filesystem events."
pkg_upstream_url=https://github.com/inotify-tools/inotify-tools/wiki
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/inotify-tools/inotify-tools/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum=0ca3d5a632149e26375bbb0b542193698bc44da027925f7b7473a5617984d7e3
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/gcc
  core/libtool
  core/make
)
pkg_bin_dirs=(bin)

do_build() {
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/libtool)/share/aclocal"
  export ACLOCAL_PATH
  ./autogen.sh
  do_default_build
}
