pkg_name=mawk
pkg_origin=core
pkg_version=1.3.4-20161120
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="An interpreter for the AWK Programming Language"
pkg_upstream_url="http://invisible-island.net/mawk/mawk.html"
pkg_license=('GPL-2.0')
pkg_source=https://invisible-mirror.net/archives/${pkg_name}/${pkg_name}-${pkg_version}.tgz
pkg_shasum=361ec1bb4968c1f1f3b91b77493cf11b31c73ff8516f95db30e4dc28de180c1e
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
)
pkg_deps=(core/glibc)
pkg_bin_dirs=(bin)

do_check() {
  for file in test/mawktest test/fpe_test; do
    sed -i'' "s|PATH=/bin:/usr/bin|PATH=/bin:/usr/bin:$PATH|g" $file
  done
  make check
}
