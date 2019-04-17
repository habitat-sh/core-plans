source "$(dirname "${BASH_SOURCE[0]}")/../prometheus/plan.sh"

pkg_name=prometheus2
pkg_origin=core
pkg_version=2.9.1
pkg_upstream_url=http://prometheus.io
pkg_description="Prometheus monitoring"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=3b234b15e16284ece013ed23d10c1f102041dc00c4ad39ac3af6265005494844
prom_pkg_dir="${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
