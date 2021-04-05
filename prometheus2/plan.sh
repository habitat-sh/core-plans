source "$(dirname "${BASH_SOURCE[0]}")/../prometheus/plan.sh"

pkg_name=prometheus2
pkg_origin=core
pkg_version=2.25.2
pkg_upstream_url=http://prometheus.io
pkg_description="Prometheus monitoring"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=85f50c0cfb4db206a59d2c3301e02d685c3fe4b451b41ca943a4eb94935cf4d4
prom_pkg_dir="${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
pkg_build_deps=(
  "${pkg_build_deps[@]}"
  core/yarn
  core/coreutils
)

do_before() {
  ln -fs "$(pkg_path_for core/coreutils)/bin/env" "/usr/bin/env"
}

do_build() {
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
  fix_interpreter "./scripts/build_react_app.sh" "core/bash" "bash"
  USER="root" PREFIX="${pkg_prefix}/bin" make build
  popd || exit 1
}
