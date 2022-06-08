pkg_name=kafka2
pkg_root_name="kafka"
pkg_origin=core
pkg_version=2.8.1
pkg_source="https://downloads.apache.org/${pkg_root_name}/${pkg_version}/${pkg_root_name}_2.13-${pkg_version}.tgz"
pkg_shasum="4888b03e3b27dd94f2d830ce3bae9d7d98b0ccee3a5d30c919ccb60e0fa1f139"
pkg_dirname="${pkg_root_name}_2.13-${pkg_version}"
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
  cp -R libs bin "${pkg_prefix}"
}
