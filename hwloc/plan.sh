pkg_name=hwloc
pkg_origin=core
pkg_major_minor=2.6
pkg_version="${pkg_major_minor}.0"
pkg_description="Portable Hardware Locality"
pkg_upstream_url=https://www.open-mpi.org/software/hwloc
pkg_license=('BSD-2-Clause')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://www.open-mpi.org/software/hwloc/v${pkg_major_minor}/downloads/hwloc-${pkg_version}.tar.gz"
pkg_shasum=9aa7e768ed4fd429f488466a311ef2191054ea96ea1a68657bc06ffbb745e59f
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  make check
}
