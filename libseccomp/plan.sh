pkg_name=libseccomp
pkg_version=2.5.3
pkg_origin=core
pkg_license=('LGPL-2.1')
pkg_description="An easy to use, platform independent, interface
to the Linux Kernel's syscall filtering mechanism."
pkg_upstream_url="https://github.com/seccomp/libseccomp"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/seccomp/libseccomp/releases/download/v${pkg_version}/libseccomp-${pkg_version}.tar.gz"
pkg_shasum=59065c8733364725e9721ba48c3a99bbc52af921daf48df4b1e012fbc7b10a76
pkg_deps=(core/glibc core/gperf)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
