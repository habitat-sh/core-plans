source "$(dirname "${BASH_SOURCE[0]}")/../prometheus/plan.sh"

pkg_name=prometheus1
pkg_origin=core
pkg_description="Prometheus monitoring"
pkg_upstream_url=http://prometheus.io
pkg_version=1.6.1
pkg_maintainer="Lamont Lucas <lamont@fastrobot.com>"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
# not used, since I actually git clone the repo and checkout the pkg_version branch
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=ecc9ce94fce45994c23b76eb0c5acbb1b942513be601872c8cd74d0821450c5e
prom_pkg_dir="$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
