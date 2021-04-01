pkg_origin=core
pkg_name=zstd
pkg_version=1.4.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_description="Zstandard is a real-time compression algorithm, providing high compression ratios. "\
"It offers a very wide range of compression / speed trade-off, while being backed by a very fast decoder"
pkg_upstream_url=http://facebook.github.io/zstd/
pkg_source="https://github.com/facebook/zstd/archive/v${pkg_version}.tar.gz"
pkg_shasum=acf714d98e3db7b876e5b540cbf6dee298f60eb3c0723104f6d3f065cd60d6a8
pkg_deps=(
  core/glibc
  core/grep
  core/less
)
pkg_build_deps=(
  core/gcc
  core/make
  core/diffutils
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build () {
  make PREFIX="${pkg_prefix}"
}

# Note that this will take a while because it runs a few compressions(v1 -> v20)
# Also, runs a fuzzer for 5 minutes + 2 min(zbufftest) + 2 min(zstreamtest)
do_check () {
  make test
}
