pkg_name=kafka
pkg_origin=core
pkg_version=2.2.1
scala_version=2.12
pkg_source="http://archive.apache.org/dist/${pkg_name}/${pkg_version}/${pkg_name}_${scala_version}-${pkg_version}.tgz"
pkg_shasum=1b8f4f94514fd1f35dc2aba0114b56cf69afa0027184f2a2964625fc1bb46deb
pkg_dirname="${pkg_name}_${scala_version}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A distributed streaming platform"
pkg_upstream_url="https://kafka.apache.org/"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_deps=(
  core/bash-static
  core/coreutils
  core/openjdk11
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
