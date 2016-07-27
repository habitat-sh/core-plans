pkg_name=swig
pkg_origin=core
pkg_version=3.0.10
pkg_license=('GPL-3.0')
pkg_description="Generate scripting interfaces to C/C++ code"
pkg_upstream_url="http://www.swig.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://prdownloads.sourceforge.net/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=2939aae39dec06095462f1b95ce1c958ac80d07b926e48871046d17c0094f44c
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
