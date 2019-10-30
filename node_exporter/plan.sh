pkg_name=node_exporter
pkg_description="Prometheus node exporter"
pkg_upstream_url=http://prometheus.io
pkg_origin=core
pkg_version=0.18.1
pkg_maintainer="Lamont Lucas <lamont@fastrobot.com>"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_source="https://github.com/prometheus/node_exporter/archive/v${pkg_version}.tar.gz"
pkg_shasum=9ddf187c462f2681ab4516410ada0e6f0f03097db6986686795559ea71a07694
pkg_build_deps=(
  core/go
  core/git
  core/make
  core/gcc
)
pkg_exports=(
  [metric-http-port]=web.listen_port
)
pkg_exposes=(metric-http-port)

do_begin() {
  export GOPATH="/hab/cache"
  parent_go_path="${GOPATH}/src/github.com/prometheus"
  return 0
}

do_prepare() {
  mkdir -p "${parent_go_path}"
  ln -s "${PWD}" "${parent_go_path}/${pkg_name}"
  return $?
}

do_build() {
  pushd "${parent_go_path}/${pkg_name}" > /dev/null
  go build .
  local code=$?
  popd > /dev/null
  return ${code}
}

do_install() {
  install node_exporter "${pkg_prefix}/bin/node_exporter"
}
