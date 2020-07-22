pkg_name=prometheus
pkg_description="Prometheus monitoring"
pkg_upstream_url=http://prometheus.io
pkg_origin=core
pkg_version=2.13.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=5624c16728679362cfa46b76ec1d247018106989f2260d35583c42c49c5142b5
prom_pkg_dir="${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
pkg_build_deps=(
  core/go
  core/git
  core/gcc
  core/make
)
pkg_exports=(
  [prom_ds_http]=listening_port
)
pkg_exposes=(prom_ds_http)
pkg_binds_optional=(
  [targets]="metric-http-port"
)

do_setup_environment() {
  export GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
}

do_unpack() {
  mkdir -p "${prom_pkg_dir}/src/github.com/prometheus/prometheus"
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
  tar xf "${HAB_CACHE_SRC_PATH}/${pkg_filename}" --strip 1 --no-same-owner
  popd || exit 1
}

do_build() {
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
  USER="root" PREFIX="${pkg_prefix}/bin" make build
  popd || exit 1
}

do_check() {
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
  make test
  popd || exit 1
}

do_install() {
  return 0
}
