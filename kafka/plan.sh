pkg_name=kafka
pkg_origin=core
pkg_version=2.7.0
pkg_source="https://downloads.apache.org/${pkg_name}/${pkg_version}/${pkg_name}_2.13-${pkg_version}.tgz"
pkg_shasum="1dd84b763676a02fecb48fa5d7e7e94a2bf2be9ff87bce14cf14109ce1cb7f90"
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
