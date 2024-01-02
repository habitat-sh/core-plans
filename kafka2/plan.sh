pkg_name=kafka2
pkg_root_name="kafka"
pkg_origin=core
pkg_version=2.8.1
pkg_source="https://archive.apache.org/dist/kafka/${pkg_version}/kafka-${pkg_version}-src.tgz"
pkg_shasum="ce7aa880c083391bc556af4e9a70d864f62e147983980562580f25bad106bdb7"
pkg_dirname="kafka-${pkg_version}-src"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A distributed streaming platform"
pkg_upstream_url="https://kafka.apache.org/"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_deps=(
  core/bash-static
  core/coreutils
  core/corretto11
)
pkg_binds=(
  [zookeeper]="port"
)

do_build() {
  fix_interpreter "./bin/*" core/bash-static bin/bash
}

do_install() {
  cp -R bin "${pkg_prefix}"
}
