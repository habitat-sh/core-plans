pkg_name=prometheus
pkg_description="Prometheus monitoring"
pkg_upstream_url=http://prometheus.io
pkg_origin=core
pkg_version=2.31.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=869a8be315721115be628f766ec3ff71aa50f1a027cee776ea54d7ba070a5026
prom_pkg_dir="${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
pkg_deps=(
  core/bash
)
pkg_build_deps=(
  core/go
  core/git
  core/gcc
  core/make
  core/yarn
  core/coreutils
  core/which
  core/node16
)
pkg_exports=(
  [prom_ds_http]=listening_port
)
pkg_exposes=(prom_ds_http)
pkg_binds_optional=(
  [targets]="metric-http-port"
)

do_setup_environment() {
  build_line "Setting GOPATH=${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  export GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
}

do_unpack() {
  mkdir -p "${prom_pkg_dir}/src/github.com/prometheus/prometheus"
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
  tar xf "${HAB_CACHE_SRC_PATH}/${pkg_filename}" --strip 1 --no-same-owner
  popd || exit 1
}

do_before() {
  ln -fs "$(pkg_path_for core/coreutils)/bin/env" "/usr/bin/env"
}

do_build() {
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
  fix_interpreter "./scripts/build_react_app.sh" "core/bash" "bash"
  USER="root" PREFIX="${pkg_prefix}/bin" make build
  popd || exit 1
}

do_check() {
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
  export CI=true
  make test
  popd || exit 1
}

do_install() {
  return 0
}
