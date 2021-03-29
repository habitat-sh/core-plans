pkg_origin=core
pkg_name=userspace-rcu
pkg_version=0.12.2
pkg_description="liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library.
  This data synchronization library provides read-side access which scales
  linearly with the number of cores."
pkg_upstream_url=http://liburcu.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source=http://www.lttng.org/files/urcu/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=4eefc11e4f6c212fc7d84d871e1cc139da0669a46ff3fda557a6fdd4d74ca67b
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
