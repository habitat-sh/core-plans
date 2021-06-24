pkg_name=swig
pkg_origin=core
pkg_version=3.0.12
pkg_license=('GPL-3.0')
pkg_description="Generate scripting interfaces to C/C++ code"
pkg_upstream_url="http://www.swig.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://prdownloads.sourceforge.net/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=7cf9f447ae7ed1c51722efc45e7f14418d15d7a1e143ac9f09a668999f4fc94d
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
)
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/pcre
)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
