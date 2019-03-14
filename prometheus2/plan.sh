source "$(dirname "${BASH_SOURCE[0]}")/../prometheus/plan.sh"

pkg_name=prometheus2
pkg_origin=core
pkg_version=2.7.1
pkg_description="Prometheus monitoring"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=fe239e23379ce6d50c5577f515d7f576f1c6f9396ea47fd87c08fbf8b5e163fb
prom_pkg_dir="$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
