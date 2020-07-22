pkg_name=kafka
pkg_origin=core
pkg_version=2.5.0
pkg_source="https://downloads.apache.org/${pkg_name}/${pkg_version}/${pkg_name}_2.13-${pkg_version}.tgz"
pkg_shasum="112b00678428595ff871a96215e9fd2c36d042220c29b1e91275988e623c6f70"
pkg_dirname="${pkg_name}_2.13-${pkg_version}"
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
