source "$(dirname "${BASH_SOURCE[0]}")/../prometheus/plan.sh"

pkg_name=prometheus2
pkg_origin=core
pkg_version=2.9.2
pkg_upstream_url=http://prometheus.io
pkg_description="Prometheus monitoring"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=fa00bdfcd868c84c61223dfe60eb3bc67777857e49db2c826854c706c5ea4551
prom_pkg_dir="${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
