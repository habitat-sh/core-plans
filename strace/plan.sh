pkg_name=strace
pkg_origin=core
pkg_version=4.19
pkg_license=('strace')
pkg_description="strace is a system call tracer for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://strace.io/"
pkg_source=http://downloads.sourceforge.net/project/strace/strace/${pkg_version}/strace-${pkg_version}.tar.xz
pkg_shasum=7c93ebc6c29280f47c24a0eb86873a99ccb2cac6512c60a60ba4ef99ab807281
pkg_deps=(core/glibc core/libunwind)
pkg_bin_dirs=(bin)
pkg_build_deps=(core/coreutils core/make core/gcc core/diffutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_check() {
  make check
}
