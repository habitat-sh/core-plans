pkg_origin=core
pkg_name=inotify-tools
pkg_version=3.20.2.2
pkg_description="inotify-tools is a C library and a set of command-line programs for Linux providing a simple interface to inotify. These programs can be used to monitor and act upon filesystem events."
pkg_upstream_url=https://github.com/inotify-tools/inotify-tools/wiki
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/inotify-tools/inotify-tools/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=c5b018567814ea555d716f518b6e3ae243c733f7bd3e8585d81748a6da286f3c
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
