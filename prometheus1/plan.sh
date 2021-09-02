source "$(dirname "${BASH_SOURCE[0]}")/../prometheus/plan.sh"

pkg_name=prometheus1
pkg_origin=core
pkg_description="Prometheus monitoring"
pkg_upstream_url=http://prometheus.io
pkg_version=1.8.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=7c8a9c9756790d1c4eb436bb6ebda49e2f671a6319c06a1c63d5df9eff7da0e2
prom_pkg_dir="$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}"
prom_build_dir="${prom_pkg_dir}/src/${pkg_source}"
pkg_deps=()
pkg_build_deps=(
  core/coreutils
  core/go
  core/gcc
  core/make
  core/patch
)

do_setup_environment() {
  build_line "Setting GOPATH=${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  export GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"

  # prometheus 1.x didn't use go modules
  export GO111MODULE=off
}

do_before() {
  return 0
}

do_build() {
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
    # prometheus 1.x didn't use go modules, but the prometheus builder
    # github.com/prometheus/promu does, we have to set GO111MODULE=on
    # in the Makefile for the go get command
    patch < "$PLAN_CONTEXT/makefile.patch"
  popd || exit 1
}

do_install() {
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus" || exit 1
    PREFIX="${pkg_prefix}/bin" make build
  popd || exit 1
}
