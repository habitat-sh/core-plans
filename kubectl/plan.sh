pkg_name=kubectl
pkg_origin=core
pkg_description="kubectl CLI tool"
pkg_upstream_url=https://github.com/kubernetes/kubernetes
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.8.3
pkg_source=https://github.com/kubernetes/kubernetes/archive/v${pkg_version}.tar.gz
pkg_shasum=8ab7e41126dfc3bc1a23ff76efc20e5131320530dc1277e5c2ed8c9618041b95
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
