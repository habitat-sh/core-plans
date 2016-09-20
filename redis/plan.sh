pkg_name=redis
pkg_origin=core
pkg_version=3.2.3
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url=http://redis.io/
pkg_license=('BSD-3-Clause')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.redis.io/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=674e9c38472e96491b7d4f7b42c38b71b5acbca945856e209cb428fbc6135f15
pkg_bin_dirs=(bin)
pkg_build_deps=(core/make core/gcc)
pkg_deps=(core/glibc)
pkg_svc_run="redis-server $pkg_svc_config_path/redis.config"
pkg_expose=(6379)

do_build() {
  make
}
