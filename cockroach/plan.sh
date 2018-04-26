pkg_name=cockroach
pkg_origin=core
pkg_version=1.1.7
pkg_description="CockroachDB is a cloud-native SQL database for building global, scalable cloud services that survive disasters."
pkg_upstream_url=https://github.com/cockroachdb/cockroach
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://binaries.cockroachdb.com/cockroach-v${pkg_version}.src.tgz
pkg_shasum=f6ce7290ba1eac5dd5e94d1ef44cd3c1f52ef01622d0b4a8c8797c0b7cb53b00
pkg_dirname="${pkg_name}-v${pkg_version}"
pkg_deps=(
  core/coreutils
  core/gcc-libs
)
pkg_build_deps=(
  core/make
  core/which
  core/go
  core/gcc
  core/cmake
  core/autoconf
)
pkg_bin_dirs=(bin)


do_build() {
  fix_interpreter "src/github.com/cockroachdb/cockroach/scripts/*.sh" core/coreutils bin/env

  make build
}

do_install() {
  pushd "./src/github.com/cockroachdb/cockroach" > /dev/null
  cp -v cockroach bin/* "${pkg_prefix}/bin/"
  popd > /dev/null
}
