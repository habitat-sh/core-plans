_upstream_ver=r131
pkg_origin=core
pkg_name=lz4
pkg_version=0.0~${_upstream_ver}
pkg_dirname=${pkg_name}-${_upstream_ver}
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2 Clause' 'GPL-2.0')
pkg_source=https://github.com/Cyan4973/lz4/archive/${_upstream_ver}.tar.gz
pkg_shasum=9d4d00614d6b9dec3114b33d1224b6262b99ace24434c53487a0c8fd0b18cfed
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/Cyan4973/lz4
pkg_description="Extremely Fast Compression algorithm http://www.lz4.org"


do_build () {
  make PREFIX="$pkg_prefix"
}

# Tests will fail until valgrind is available.
#do_check () {
#  make test
#}
