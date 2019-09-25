pkg_name=telegraf
pkg_origin=core
pkg_version=1.12.2
pkg_license=('MIT')
pkg_description="telegraf - client for InfluxDB"
pkg_upstream_url="https://github.com/influxdata/telegraf/"
pkg_source="https://dl.influxdata.com/${pkg_name}/releases/${pkg_name}-${pkg_version}-static_linux_amd64.tar.gz"
pkg_shasum=dab9ae72b53c99f93e708ab911d556d6906c0691c6858da09b4e74e24e344c8a
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
  install -vD "${HAB_CACHE_SRC_PATH}/telegraf/telegraf" "${pkg_prefix}/bin/telegraf"
}
