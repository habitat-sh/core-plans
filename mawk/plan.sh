pkg_name=mawk
pkg_origin=core
pkg_version=1.3.4-20200120
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="An interpreter for the AWK Programming Language"
pkg_upstream_url="http://invisible-island.net/mawk/mawk.html"
pkg_license=('GPL-2.0')
pkg_source=http://invisible-mirror.net/archives/${pkg_name}/${pkg_name}-${pkg_version}.tgz
pkg_shasum=7fd4cd1e1fae9290fe089171181bbc6291dfd9bca939ca804f0ddb851c8b8237
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
