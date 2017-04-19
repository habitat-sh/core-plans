pkg_origin=core
pkg_name=cmatrix
pkg_version=1.2a
pkg_description="Brings the matrix to your terminal"
pkg_upstream_url=http://www.asty.org/cmatrix/
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.asty.org/cmatrix/dist/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=1fa6e6caea254b6fe70a492efddc1b40ad7ccb950a5adfd80df75b640577064c
pkg_deps=(core/glibc core/ncurses)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)

do_check() {
  make test
}
