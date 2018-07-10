pkg_name=filebeat
pkg_origin=core
pkg_version="6.3.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_build_deps=(core/go core/git core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_binds_optional=(
  [kibana]="port"
  [elasticsearch]="http-port"
  [logstash]="port"
)
pkg_description="Lightweight shipper for logfiles"
pkg_upstream_url="https://www.elastic.co/products/beats/filebeat"

do_download() {
  GOPATH=$(dirname "${HAB_CACHE_SRC_PATH}")
  export GOPATH
  build_line "Fetching Go sources."
  go get github.com/elastic/beats/filebeat
  pushd "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/filebeat" > /dev/null
  git checkout "v${pkg_version}"
  popd > /dev/null
}

do_unpack() {
  return 0
}

do_build() {
  pushd "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/filebeat" > /dev/null
  make
  popd > /dev/null
}

do_install() {
  install -D "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/filebeat/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
