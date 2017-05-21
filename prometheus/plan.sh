pkg_name=prometheus
pkg_description="Prometheus monitoring"
pkg_upstream_url=http://prometheus.io
pkg_origin=core
pkg_version=1.6.1
pkg_maintainer="Lamont Lucas <lamont@fastrobot.com>"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
# not used, since I actually git clone the repo and checkout the pkg_version branch
pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
pkg_shasum=ecc9ce94fce45994c23b76eb0c5acbb1b942513be601872c8cd74d0821450c5e
prom_pkg_dir="$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}"
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


do_prepare() {
  export GOPATH=$HAB_CACHE_SRC_PATH/$pkg_dirname
}

# since I'm cloning a git repo, override download and verify callbacks to do nothing
do_download() {
  return 0
}

do_verify () {
  return 0
}

do_unpack() {
  mkdir -p $prom_pkg_dir/src/github.com/prometheus
  pushd $prom_pkg_dir/src/github.com/prometheus
  git clone --branch v${pkg_version} https://github.com/prometheus/prometheus.git
  popd
}

do_build() {
  pushd ${prom_pkg_dir}/src/github.com/prometheus/prometheus
  make build
  $GOPATH/bin/promu build --prefix $pkg_prefix/bin
  popd
  return 0
}

do_install() {
  return 0
}
