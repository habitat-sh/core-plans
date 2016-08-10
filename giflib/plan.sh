pkg_name=giflib
pkg_version=5.1.4
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="GIFLIB is a package of portable tools and library routines for working with GIF images.
Also commonly known as libgif."
pkg_upstream_url=http://giflib.sourceforge.net/
pkg_source=http://downloads.sourceforge.net/sourceforge/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=34a7377ba834397db019e8eb122e551a49c98f49df75ec3fcc92b9a794a4f6d1
pkg_deps=(core/glibc)
pkg_build_deps=(core/diffutils core/gcc core/make)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
