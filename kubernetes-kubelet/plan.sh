pkg_name=kubernetes-kubelet
pkg_origin=core
pkg_description="Production-Grade Container Scheduling and Management"
pkg_upstream_url=https://github.com/kubernetes/kubernetes
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.23.0
pkg_deps=("core/kubernetes/1.23.0")
pkg_svc_user="root"
pkg_svc_group="${pkg_svc_user}"

do_build() {
  return 0
}

do_install() {
  cp -r "static" "${pkg_prefix}/"
}
