pkg_name=prometheus
pkg_description="Prometheus monitoring example for Hab POC"
pkg_upstream_url=http://prometheus.io
pkg_origin=core
##the version of prometheus we wil be pulling down
pkg_version=2.3.1
pkg_maintainer="kkwentus@chef.io"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
# not used, since in do_upnack an explicit git clone the repo and checkout are called.  This could be changed
#pkg_source="https://github.com/prometheus/prometheus/archive/v${pkg_version}.tar.gz"
#pkg_shasum=adb76021fcff8a2a8363de8739fcb7ff5647c2a0ff90b2c02dcb56cf0cd836f0
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
  mkdir -p "$prom_pkg_dir/src/github.com/prometheus"
  pushd "$prom_pkg_dir/src/github.com/prometheus"
  git clone --branch v${pkg_version} https://github.com/prometheus/prometheus.git
  popd
}

do_build() {
  pushd "${prom_pkg_dir}/src/github.com/prometheus/prometheus"
  make build
  "$GOPATH/bin/promu" build --prefix "$pkg_prefix/bin"
  popd
  return 0
}

do_install() {
  return 0
}
