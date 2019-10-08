pkg_origin=core
pkg_name=memcached
pkg_version=1.5.19
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Distributed memory object caching system"
pkg_upstream_url="https://memcached.org/"
pkg_license=('BSD')
pkg_source="http://www.memcached.org/files/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=3ddcdaa2d14d215f3111a7448b79c889c57618a26e97ad989581f1880a5a4be0
pkg_deps=(
  core/glibc
  core/cyrus-sasl
  core/libevent
)
pkg_build_deps=(
  core/git
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_svc_run="memcached"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-sasl
  make
}

do_check() {
  make test
}
