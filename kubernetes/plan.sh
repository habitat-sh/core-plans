pkg_name=kubernetes
pkg_origin=core
pkg_description="Production-Grade Container Scheduling and Management"
pkg_upstream_url=https://github.com/kubernetes/kubernetes
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.8.3
pkg_source=https://github.com/kubernetes/kubernetes/archive/v${pkg_version}.tar.gz
pkg_shasum=8ab7e41126dfc3bc1a23ff76efc20e5131320530dc1277e5c2ed8c9618041b95

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

do_prepare() {
  patch hack/lib/golang.sh "${PLAN_CONTEXT}/golang_detection.patch"
}

do_build() {
  make
  return $?
}

do_install() {
  cp _output/bin/* "${pkg_prefix}/bin"
  return $?
}
