pkg_origin=test
pkg_name=testhaproxy
pkg_description="Test plan for the core/haproxy load balancer"
pkg_version=1.6.11
pkg_maintainer="The Habitat Maintainers: <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_svc_run="haproxy -f $pkg_svc_config_path/haproxy.conf -db"
pkg_svc_user="root"
pkg_svc_group="root"
pkg_exports=(
  [port]=front-end.port
  [status-port]=status.port
)
pkg_exposes=(port status-port)
pkg_binds=(
  [backend]="port"
)
pkg_deps=( $HAB_ORIGIN/haproxy )

do_install() {
  return 0
}

do_build() {
  return 0
}

do_download() {
  return 0
}