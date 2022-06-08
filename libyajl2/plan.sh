pkg_name=libyajl2
pkg_origin=core
pkg_version="2.1.0"
pkg_description="Yet Another JSON Library"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("ISC")
pkg_upstream_url="https://github.com/lloyd/yajl"
pkg_source="https://github.com/lloyd/yajl/archive/refs/tags/${pkg_version}.tar.gz"
pkg_dirname="yajl-${pkg_version}"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a"
pkg_deps=(core/glibc)
pkg_build_deps=(core/busybox-static core/cmake core/doxygen core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(share/pkgconfig)

do_install() {
  for type in bin include lib share; do
    cp -r ${CACHE_PATH}/build/yajl-${pkg_version}/${type} ${pkg_prefix};
  done
}
