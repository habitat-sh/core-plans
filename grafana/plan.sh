pkg_name=grafana
pkg_origin=core
pkg_version="4.2.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_upstream_url=https://grafana.com/
pkg_source="https://s3-us-west-2.amazonaws.com/${pkg_name}-releases/release/${pkg_name}-${pkg_version}.linux-x64.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.linux-x64.tar.gz"
pkg_shasum="e9927baaaf6cbcab64892dedd11ccf509e4edea54670db4250b9e7568466ec61"
pkg_deps=(core/glibc core/bash core/wget core/curl core/cacerts)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)
pkg_description="Grafana graphing app, dynamically finds prometheus data sources"

pkg_exports=(
  [grafana_port]=listening_port
)

pkg_exposes=(grafana_port)

pkg_binds_optional=(
  [prom]="prom_ds_http"
)

do_unpack() {
  pushd "${HAB_CACHE_SRC_PATH}"
  tar zxf ${pkg_filename}
  popd
  return 0
}

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
