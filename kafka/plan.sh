pkg_name=kafka
pkg_origin=core
pkg_version=0.10.2.2
pkg_source="http://archive.apache.org/dist/${pkg_name}/${pkg_version}/${pkg_name}_2.11-${pkg_version}.tgz"
pkg_shasum="60f587ed8d1ee6e8e8057f13da6eee472f95c8d2ea691f6aab74edb842dc9950"
pkg_dirname="${pkg_name}_2.11-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A distributed streaming platform"
pkg_upstream_url="https://kafka.apache.org/"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_deps=(
  core/bash-static
  core/coreutils
  core/jre8
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
