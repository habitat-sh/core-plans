pkg_name=kubectl
pkg_origin=core
pkg_description="kubectl CLI tool"
pkg_upstream_url=https://github.com/kubernetes/kubernetes
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.9.6
pkg_source=https://github.com/kubernetes/kubernetes/archive/v${pkg_version}.tar.gz
pkg_shasum=d0c0edba4410426bf9b7b8f9f0efd0d59816cdeaef25fc99311a90ece843c1d3
pkg_dirname="kubernetes-${pkg_version}"

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
  make kubectl
  return $?
}

do_install() {
  cp _output/bin/kubectl "${pkg_prefix}/bin/"
  return $?
}
