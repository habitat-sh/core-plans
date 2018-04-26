pkg_name=grafana
pkg_origin=core
pkg_version="4.6.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_upstream_url=https://grafana.com/
pkg_source="https://s3-us-west-2.amazonaws.com/${pkg_name}-releases/release/${pkg_name}-${pkg_version}.linux-x64.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.linux-x64.tar.gz"
pkg_shasum="037cf7678858c4a5b3632de7bea4c20475e081ff48c27c868be71e7b0a07c505"
pkg_deps=(core/glibc core/bash core/wget core/curl core/cacerts)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)
pkg_description="Grafana graphing app, dynamically finds prometheus data sources"
pkg_svc_user="root"
pkg_svc_group=$pkg_svc_user
pkg_exports=(
  [grafana_port]=listening_port
)

pkg_exposes=(grafana_port)

pkg_binds_optional=(
  [prom]="prom_ds_http"
)

# we're using prebuilt binaries; no build stage required
do_build() {
  return 0
}

do_install() {
  mkdir -p "${pkg_svc_var_path}/plugins"
  cd "$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}" || exit 1
  cp -r conf  public  scripts  vendor "${pkg_prefix}/"
  cp -r bin/* "${pkg_prefix}/bin/"
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
         "${pkg_prefix}/bin/grafana-server"
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
         "${pkg_prefix}/bin/grafana-cli"
  #install_cacerts
  return 0
}
