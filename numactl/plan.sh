pkg_origin=core
pkg_name=numactl
pkg_version=2.0.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source=https://github.com/numactl/numactl/archive/v2.0.9.tar.gz
pkg_shasum=3e893f41e601eac3100eefd659dbead8c75a89b9b73bc01c8387966181d9320c
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib64)

do_build () {
  make PREFIX=$pkg_prefix
}
