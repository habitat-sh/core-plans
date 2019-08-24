pkg_name=libatomic_ops
pkg_origin=core
pkg_version=7.6.10
pkg_description="Atomic memory update operations"
pkg_upstream_url="https://github.com/ivmai/libatomic_ops"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.ivmaisoft.com/_bin/atomic_ops/libatomic_ops-${pkg_version}.tar.gz"
pkg_shasum=587edf60817f56daf1e1ab38a4b3c729b8e846ff67b4f62a6157183708f099af
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_check() {
  make check
}
