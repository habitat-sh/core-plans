source "$(dirname "${BASH_SOURCE[0]}")/../prometheus/plan.sh"

pkg_name=prometheus1
pkg_origin=core
pkg_description="Prometheus monitoring"
pkg_upstream_url=http://prometheus.io
pkg_version=1.8.2
pkg_maintainer="Lamont Lucas <lamont@fastrobot.com>"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
# not used, since I actually git clone the repo and checkout the pkg_version branch
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=7c8a9c9756790d1c4eb436bb6ebda49e2f671a6319c06a1c63d5df9eff7da0e2
prom_pkg_dir="$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
