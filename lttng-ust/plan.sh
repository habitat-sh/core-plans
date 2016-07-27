pkg_origin=core
pkg_name=lttng-ust
pkg_version=2.8.1
pkg_description="LTTng is an open source tracing framework for Linux."
pkg_upstream_url=http://lttng.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'MIT')
pkg_source=$pkg_upstream_url/files/$pkg_name/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=6e41349107e83e7b43c69ed358e48788ca2fd095bad61737b850e3f3d2c0508a
pkg_deps=(
  core/coreutils
  core/gcc-libs
  core/glibc
  core/python2
  core/userspace-rcu
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  fix_interpreter "$HAB_CACHE_SRC_PATH/$pkg_dirname/tools/lttng-gen-tp" core/coreutils bin/env
}
