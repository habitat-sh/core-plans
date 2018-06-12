pkg_name=filebeat
pkg_origin=core
pkg_version="6.2.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
# pkg_source="https://github.com/elastic/beats/archive/v${pkg_version}.tar.gz"
# pkg_filename="${pkg_name}-${pkg_version}-linux-x86_64.tar.gz"
# # pkg_dirname="beats-${pkg_version}"
# pkg_shasum="87d863cf55863329ca80e76c3d813af2960492f4834d4fea919f1d4b49aaf699"
# pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/git core/make core/gcc)
# pkg_lib_dirs=(lib)
# pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
# pkg_pconfig_dirs=(lib/pconfig)
# pkg_svc_run="haproxy -f $pkg_svc_config_path/haproxy.conf"
# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)
# pkg_binds=(
#   [database]="port host"
# )
pkg_binds_optional=(
  [kibana]="port"
  [elasticsearch]="http-port"
  [logstash]="port"
)
# pkg_interpreters=(bin/bash)
pkg_svc_user="hab"
pkg_svc_group="${pkg_svc_user}"
pkg_description="Lightweight shipper for logfiles"
# pkg_upstream_url="http://example.com/project-name"

do_download() {
  export GOPATH=$(dirname "${HAB_CACHE_SRC_PATH}")
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
