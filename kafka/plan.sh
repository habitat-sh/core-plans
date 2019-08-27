pkg_name=kafka
pkg_origin=core
pkg_version=2.3.0
scala_version=2.12
pkg_source="http://archive.apache.org/dist/${pkg_name}/${pkg_version}/${pkg_name}_${scala_version}-${pkg_version}.tgz"
pkg_shasum=d86f5121a9f0c44477ae6b6f235daecc3f04ecb7bf98596fd91f402336eee3e7
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
