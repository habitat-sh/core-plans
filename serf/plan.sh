pkg_name=serf
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=1.3.9
pkg_description="A high performance C-based HTTP client library built upon the Apache Portable Runtime (APR) library."
pkg_upstream_url=https://serf.apache.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source=https://archive.apache.org/dist/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.bz2
pkg_shasum=549c2d21c577a8a9c0450facb5cca809f26591f048e466552240947bdf7a87cc
pkg_deps=(
  core/apr
  core/apr-util
  core/glibc
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/make
  core/patch
  core/python2
  core/scons
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  patch -i "${PLAN_CONTEXT}/pass-env-to-scons.patch"
}

do_build() {
  scons \
    PREFIX="$pkg_prefix" \
    APR="$(pkg_path_for apr)" \
    APU="$(pkg_path_for apr-util)" \
    ZLIB="$(pkg_path_for zlib)" \
    OPENSSL="$(pkg_path_for openssl)" \
    CFLAGS="$CFLAGS" \
    LINKFLAGS="$LDFLAGS"
}

# Currently errors out on a comment style in a test suite, of all things.
# test/test_buckets.c:1237:1: error: C++ style comments are not allowed in ISO C90
#  //    buf_size = orig_len + (orig_len / 1000) + 12;
#  ^
# do_check() {
#   scons check
# }

do_install() {
  scons install
}
