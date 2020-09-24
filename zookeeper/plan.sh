pkg_name=zookeeper
pkg_origin=core
pkg_version=3.6.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Apache ZooKeeper system for distributed coordination is a high-performance service for building distributed applications."
pkg_upstream_url="https://zookeeper.apache.org"
pkg_license=('Apache-2.0')
pkg_source="https://downloads.apache.org/zookeeper/zookeeper-${pkg_version}/apache-zookeeper-${pkg_version}-bin.tar.gz"
pkg_dirname="apache-${pkg_name}-${pkg_version}-bin"
pkg_shasum="476f6fce10f9528e3a4ad00e6cd1714563f602dd4924db78e506c0df28fea1e5"
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
