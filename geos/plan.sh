pkg_name=geos
pkg_origin=core
pkg_version=3.9.2
pkg_description="GEOS (Geometry Engine - Open Source) is a C++ port of the ​Java Topology Suite (JTS)."
pkg_upstream_url=http://trac.osgeo.org/geos
pkg_license=('LGPL')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.osgeo.org/geos/geos-${pkg_version}.tar.bz2
pkg_shasum=44a5a9be21d7d473436bf621c2ddcc3cf5a8bbe3c786e13229618a3b9d861297
pkg_build_deps=(
  core/gcc
  core/make
  core/patchelf
)
pkg_deps=(
  core/coreutils
  core/glibc
  core/gcc-libs
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)


do_install() {
  do_default_install

  build_line "Patching ELF binaries:"
  find "$pkg_prefix/lib" -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-sharedlib; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
}
