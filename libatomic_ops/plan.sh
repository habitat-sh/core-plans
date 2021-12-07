pkg_name=libatomic_ops
pkg_origin=core
pkg_version=7.6.12
pkg_description="Atomic memory update operations"
pkg_upstream_url="https://github.com/ivmai/libatomic_ops"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.ivmaisoft.com/_bin/atomic_ops/libatomic_ops-${pkg_version}.tar.gz"
pkg_shasum=f0ab566e25fce08b560e1feab6a3db01db4a38e5bc687804334ef3920c549f3e
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_check() {
  make check
}
