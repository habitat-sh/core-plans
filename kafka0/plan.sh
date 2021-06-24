pkg_name=kafka0
pkg_basename=kafka
pkg_origin=core
pkg_version=0.11.0.3
pkg_source="http://archive.apache.org/dist/${pkg_basename}/${pkg_version}/${pkg_basename}_2.11-${pkg_version}.tgz"
pkg_shasum="c73f1e1b8cd3d754747e5a8750e868fcb6efe5cd9dae17c828fe20d6a400837a"
pkg_dirname="${pkg_basename}_2.11-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A distributed streaming platform"
pkg_upstream_url="https://kafka.apache.org/"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_deps=(
  core/bash-static
  core/coreutils
  core/corretto8
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
