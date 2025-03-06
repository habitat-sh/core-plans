pkg_name=grafana-promtail
pkg_origin=core
pkg_version="0.4.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_upstream_url=https://github.com/grafana/loki
pkg_source="https://github.com/grafana/loki/archive/v${pkg_version}.tar.gz"
pkg_filename="v${pkg_version}.tar.gz"
pkg_shasum="aadc8faa315659d0242b2fb2e64552b6883806e577d66d57dd71bcdaddfad8fe"
loki_pkg_dir="${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
loki_build_dir="${loki_pkg_dir}/src/${pkg_source}"
pkg_build_deps=(
  core/go
  core/git
  core/gcc
  core/make
  core/busybox-static
  core/cacerts
)
pkg_deps=(
  core/systemd
)
pkg_bin_dirs=(bin)
pkg_svc_run="promtail --config.file ${pkg_svc_config_path}/config.yaml"
pkg_description="Promtail is an agent which ships the contents of local logs to a private Loki instance or Grafana Cloud."
pkg_binds=(
  [loki]="loki_ds_http"
)

do_setup_environment() {
  export GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_unpack() {
  mkdir -p "${loki_pkg_dir}/src/github.com/grafana/loki"
  pushd "${loki_pkg_dir}/src/github.com/grafana/loki" > /dev/null || exit 1
  tar xf "${HAB_CACHE_SRC_PATH}/${pkg_filename}" --strip 1 --no-same-owner
  popd > /dev/null || exit 1
}

do_prepare() {
  BASHBIN="$(pkg_path_for core/busybox-static)/bin/bash"

  pushd "${loki_pkg_dir}/src/github.com/grafana/loki" > /dev/null || exit 1
  sed -i "s,/usr/bin/env bash,${BASHBIN}," Makefile
  popd > /dev/null || exit 1
}

do_build() {
  pushd "${loki_pkg_dir}/src/github.com/grafana/loki" > /dev/null || exit 1
  # build with libsystemd
  # ref: https://github.com/grafana/loki/blob/master/production/README.md#build-and-run-from-source
  CGO_ENABLED=1 CGO_CFLAGS=${CFLAGS} go build ./cmd/promtail
  mv promtail ./cmd/promtail/promtail
  popd > /dev/null || exit 1
}

do_install() {
  pushd "${loki_pkg_dir}/src/github.com/grafana/loki" > /dev/null || exit 1
  install -Dm755 cmd/promtail/promtail "${pkg_prefix}/bin/promtail"
  popd > /dev/null || exit 1
}
