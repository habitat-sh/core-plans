pkg_name=cockroach
pkg_origin=core
pkg_version=1.0.6
pkg_description="CockroachDB is a cloud-native SQL database for building global, scalable cloud services that survive disasters."
pkg_upstream_url=https://github.com/cockroachdb/cockroach
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://binaries.cockroachdb.com/cockroach-v${pkg_version}.src.tgz
pkg_shasum=1f9b867385f6d99e8ff0f15b66e6bf7205b14617030db7482641627472eae0c8
pkg_dirname="${pkg_name}-v${pkg_version}"
pkg_deps=(
  core/coreutils
  core/gcc-libs
)
pkg_build_deps=(
  core/make
  core/which
  core/go/1.8
  core/gcc
  core/cmake
)
pkg_bin_dirs=(bin)


do_build() {
  fix_interpreter "src/github.com/cockroachdb/cockroach/scripts/*.sh" core/coreutils bin/env

  make build

  return $?
}

do_install() {
  pushd "./src/github.com/cockroachdb/cockroach" > /dev/null
  cp -v cockroach bin/* "${pkg_prefix}/bin/"
  popd > /dev/null

  return 0
}
