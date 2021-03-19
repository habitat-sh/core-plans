pkg_name=mawk
pkg_origin=core
pkg_version=1.3.4-20200120
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="An interpreter for the AWK Programming Language"
pkg_upstream_url="http://invisible-island.net/mawk/mawk.html"
pkg_license=('GPL-2.0')
pkg_source=https://invisible-mirror.net/archives/${pkg_name}/${pkg_name}-${pkg_version}.tgz
pkg_shasum=2a8c8b82721c98b2e9db181173bea1cbca6f0d623ec11874a6d8835f0245aed1
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
)
pkg_deps=(core/glibc)
pkg_bin_dirs=(bin)

do_check() {
  for file in test/mawktest test/fpe_test; do
    sed -i "s|PATH=/bin:/usr/bin|PATH=/bin:/usr/bin:$PATH|g" $file
  done
  make check
}
