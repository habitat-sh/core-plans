pkg_name=zookeeper
pkg_origin=core
pkg_version=3.6.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Apache ZooKeeper system for distributed coordination is a high-performance service for building distributed applications."
pkg_upstream_url="https://zookeeper.apache.org"
pkg_license=('Apache-2.0')
pkg_source="http://downloads.apache.org/${pkg_name}/${pkg_name}-${pkg_version}/apache-${pkg_name}-${pkg_version}-bin.tar.gz"
pkg_dirname="apache-${pkg_name}-${pkg_version}-bin"
pkg_shasum="5066dd085cee2a7435a1bb25677102f0d4ea585f314bd026799f333b0956a06d"
pkg_build_deps=()
pkg_deps=(
  core/bash-static
  core/coreutils
  core/corretto11
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=zookeeper.clientPort
)

do_build() {
  return 0
}

do_install() {
  fix_interpreter "bin/*" core/coreutils bin/env
  cp -r bin lib "${pkg_prefix}"
}
