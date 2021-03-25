pkg_name=hwloc
pkg_origin=core
pkg_major_minor=2.4
pkg_version="${pkg_major_minor}.1"
pkg_description="Portable Hardware Locality"
pkg_upstream_url=https://www.open-mpi.org/software/hwloc
pkg_license=('BSD-2-Clause')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://www.open-mpi.org/software/hwloc/v${pkg_major_minor}/downloads/hwloc-${pkg_version}.tar.gz"
pkg_shasum=392421e69f26120c8ab95d151fe989f2b4b69dab3c7735741c4e0a6d7de5de63
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  make check
}
