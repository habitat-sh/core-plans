pkg_origin=core
pkg_name=vmtouch
pkg_version=1.1.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_description="vmtouch is a tool for learning about and controlling the file system cache of unix and unix-like systems"
pkg_upstream_url=https://hoytech.com/vmtouch/
pkg_source="https://github.com/hoytech/vmtouch/archive/v${pkg_version}.tar.gz"
pkg_shasum=1ba2a12aabed977894ce3a272b2fa8ed6ddfec7a720d7686e074f9e756104796
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/perl)
pkg_bin_dirs=(bin)

do_build () {
  make PREFIX="${pkg_prefix}"
}
