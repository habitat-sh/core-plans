pkg_name=zookeeper
pkg_origin=core
pkg_version=3.4.14
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Apache ZooKeeper system for distributed coordination is a high-performance service for building distributed applications."
pkg_upstream_url="https://zookeeper.apache.org"
pkg_license=('Apache-2.0')
pkg_source="http://apache.mirrors.ionfish.org/zookeeper/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="b14f7a0fece8bd34c7fffa46039e563ac5367607c612517aa7bd37306afbd1cd"
pkg_build_deps=()
pkg_deps=(
  core/bash-static
  core/coreutils
  core/openjdk11
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

  cp -r bin lib "dist-maven/${pkg_dirname}.jar" "${pkg_prefix}"
}
