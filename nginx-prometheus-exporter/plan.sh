
pkg_name=nginx-prometheus-exporter
pkg_origin=core
pkg_version="0.9.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="NGINX Prometheus exporter makes it possible to monitor NGINX or NGINX Plus using Prometheus."
pkg_upstream_url="https://github.com/nginxinc/nginx-prometheus-exporter"
pkg_source="https://github.com/nginxinc/nginx-prometheus-exporter/archive/v${pkg_version}.tar.gz"
pkg_shasum=56d2c45eca703c4d17c5358f2a297e4f71704324fe93ffcc4707540d6d20bd27
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/make
  core/gcc
  core/git
  core/go
)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port]=web.port
)
pkg_exposes=(port)
pkg_binds_optional=(
  [nginx]="stub_status_port stub_status_path"
)

do_build() {
  make
}

do_install() {
  install -m 755 nginx-prometheus-exporter "${pkg_prefix}/bin/nginx-prometheus-exporter"
}
