pkg_origin=core
pkg_name=userspace-rcu
pkg_version=0.9.2
pkg_description="liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library.
  This data synchronization library provides read-side access which scales
  linearly with the number of cores."
pkg_upstream_url=http://liburcu.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source=http://www.lttng.org/files/urcu/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=8f7fa313b1e0a3f742cea24ce63a39c0efe63e615a769e2961e55bd2663ecaa3
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
