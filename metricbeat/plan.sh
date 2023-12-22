pkg_name=metricbeat
pkg_origin=core
pkg_version=7.16.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_deps=(core/glibc core/systemd)
pkg_build_deps=(
  core/go
  core/git
  core/mage
  core/gcc
  core/cacerts
)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root
pkg_description="Metricbeat is a lightweight shipper for metrics with Elasticsearch."
pkg_upstream_url="https://elastic.co/products/beats/metricbeat"

do_prepare() {
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_download() {
  SYSTEMD_INCLUDE_PATH=$(pkg_path_for core/systemd)/include
  GOPATH="$(dirname "${HAB_CACHE_SRC_PATH}")"
  export GOPATH
  rm -rf "${GOPATH}/src/github.com/elastic/beats"
  git clone https://github.com/elastic/beats "${GOPATH}"/src/github.com/elastic/beats
  pushd "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/metricbeat" > /dev/null || exit 1
  git checkout "v${pkg_version}"
  popd > /dev/null || exit 1
}

do_build() {
  SYSTEMD_INCLUDE_PATH=$(pkg_path_for core/systemd)/include
  pushd "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/metricbeat" > /dev/null || exit 1
  mage build
  popd > /dev/null || exit 1
}

do_install() {
  install -D "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/metricbeat/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
