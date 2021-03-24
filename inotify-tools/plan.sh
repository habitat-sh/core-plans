pkg_origin=core
pkg_name=inotify-tools
pkg_version=3.20.11.0
pkg_description="inotify-tools is a C library and a set of command-line programs for Linux providing a simple interface to inotify. These programs can be used to monitor and act upon filesystem events."
pkg_upstream_url=https://github.com/inotify-tools/inotify-tools/wiki
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/inotify-tools/inotify-tools/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
