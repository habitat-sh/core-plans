pkg_name=ed
pkg_origin=core
pkg_version=1.13
pkg_description="The standard text editor."
pkg_upstream_url="https://www.gnu.org/software/ed/"
pkg_license=('GPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/gnu/ed/ed-${pkg_version}.tar.lz"
pkg_shasum=cd66c54a53cd6ef35a217556e7b2b2fdd973ca2708f4fc41636b0bc06388c7d3
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/lzip core/diffutils)
pkg_bin_dirs=(bin)

do_unpack() {
  mkdir -p "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  lzip -d --stdout "${HAB_CACHE_SRC_PATH}/${pkg_filename}" | tar x -C "${HAB_CACHE_SRC_PATH}/"
}

do_check() {
  make check
}
