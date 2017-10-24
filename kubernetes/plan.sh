pkg_name=kubernetes
pkg_origin=core
pkg_description="Production-Grade Container Scheduling and Management"
pkg_upstream_url=https://github.com/kubernetes/kubernetes
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.7.5
pkg_source=https://github.com/kubernetes/kubernetes/archive/v${pkg_version}.tar.gz
pkg_shasum=eeb8e6fa45bdbf4974d3d20b50b753544e576b96b5ad731c88a4e16ebe357fd6

pkg_bin_dirs=(bin)

pkg_build_deps=(
  core/git
  core/make
  core/gcc
  core/go
  core/diffutils
  core/which
  core/rsync
)

pkg_deps=(
  core/glibc
)

do_build() {
  make
  return $?
}

do_install() {
  cp _output/bin/* "${pkg_prefix}/bin"
  return $?
}
