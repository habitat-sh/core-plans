pkg_name=zookeeper
pkg_origin=core
pkg_version=3.7.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Apache ZooKeeper system for distributed coordination is a high-performance service for building distributed applications."
pkg_upstream_url="https://zookeeper.apache.org"
pkg_license=('Apache-2.0')
pkg_source="https://archive.apache.org/dist/zookeeper/zookeeper-${pkg_version}/apache-zookeeper-${pkg_version}-bin.tar.gz"
pkg_dirname="apache-${pkg_name}-${pkg_version}-bin"
pkg_shasum="2f265d27b40fcba5ccf6c56c4c38fb224e24e4155a0bea65ee681a7e20f7c215"
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
