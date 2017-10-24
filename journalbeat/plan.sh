pkg_svc_user="root"
pkg_name="journalbeat"
pkg_description="Journalbeat is a log shipper from systemd/journald to Logstash/Elasticsearch"
pkg_origin="core"
pkg_version="5.5.2"
pkg_maintainer="smartB Engineering <dev@smartb.eu>"
pkg_license=('Apache 2')
pkg_upstream_url="https://github.com/mheese/journalbeat"
pkg_source="https://github.com/mheese/$pkg_name/archive/v$pkg_version.tar.gz"
pkg_shasum="3cc431a199226b14e318610ee5cfd08d2f3109dc9850591f73a28219c56753c9"
pkg_deps=(
  core/lz4
  core/systemd
)
pkg_build_deps=(
  core/go
  core/git
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_begin() {
  export GOPATH="/hab/cache"
  parent_go_path="${GOPATH}/src/github.com/mheese"
}

do_clean() {
  do_default_clean
  rm -rf "${parent_go_path}"
}

do_prepare() {
  mkdir -p "${parent_go_path}"
  ln -s "${PWD}" "${parent_go_path}/${pkg_name}"
  export C_INCLUDE_PATH
  C_INCLUDE_PATH="$(pkg_path_for core/systemd)/include"
}

do_build() {
  pushd "${parent_go_path}/${pkg_name}" > /dev/null
    go build
    local code=$?
  popd > /dev/null
  return $code
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp "${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
