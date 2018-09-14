pkg_origin=core
pkg_name=memcached
pkg_version=1.5.10
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Distributed memory object caching system"
pkg_upstream_url="https://memcached.org/"
pkg_license=('BSD')
pkg_source=http://www.memcached.org/files/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=494c060dbd96d546c74ab85a3cc3984d009b4423767ac33e05dd2340c01f1c4b
pkg_deps=(
  core/glibc
  core/libevent
  core/libsasl2
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
