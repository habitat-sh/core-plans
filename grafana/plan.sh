pkg_name=grafana
pkg_origin=core
pkg_version=7.5.11
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_upstream_url=https://grafana.com/
pkg_source="https://dl.grafana.com/oss/release/${pkg_name}-${pkg_version}.linux-amd64.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.linux-amd64.tar.gz"
pkg_shasum=3244d0ced48d2de9726c9a3bd6d5f08c1b6a081d42665401e033fc4a31c57d5d
pkg_deps=(
  core/glibc
  core/bash
  core/wget
  core/curl
  core/cacerts
)
pkg_build_deps=(
  core/patchelf
)
pkg_bin_dirs=(bin)
pkg_description="Grafana graphing app, dynamically finds prometheus data sources"
pkg_svc_user=root
pkg_svc_group="${pkg_svc_user}"
pkg_exports=(
  [grafana_port]=listening_port
)
pkg_exposes=(grafana_port)
pkg_binds_optional=(
  [prom]="prom_ds_http"
  [loki]="loki_ds_http"
)

# we're using prebuilt binaries; no build stage required
do_build() {
  return 0
}

do_install() {
  cp -r conf public scripts plugins-bundled "${pkg_prefix}/"
  cp -r bin/* "${pkg_prefix}/bin/"
  patchelf \
    --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    "${pkg_prefix}/bin/grafana-server"
  patchelf \
    --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    "${pkg_prefix}/bin/grafana-cli"
}
