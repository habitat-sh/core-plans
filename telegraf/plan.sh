pkg_name=telegraf
pkg_origin=core
pkg_version=1.18.1
pkg_license=('MIT')
pkg_description="telegraf - client for InfluxDB"
pkg_upstream_url="https://github.com/influxdata/telegraf/"
pkg_source="https://dl.influxdata.com/${pkg_name}/releases/${pkg_name}-${pkg_version}_static_linux_amd64.tar.gz"
pkg_shasum=e1be5cbc3d8e48f5919ebf3044c25555c8210ab11a0803d2feeb94c0f4ddebba
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_svc_run="telegraf --config ${pkg_svc_config_path}/telegraf.conf"
pkg_build_deps=(
  core/wget
  core/tar
)
pkg_deps=()
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  install -vD "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}/usr/bin/telegraf" "${pkg_prefix}/bin/telegraf"
}
