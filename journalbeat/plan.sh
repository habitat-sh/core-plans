pkg_name=journalbeat
pkg_origin=core
pkg_version=7.11.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_deps=(
  core/glibc
  core/systemd
)
pkg_build_deps=(
  core/go
  core/git
  core/mage
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root
pkg_description="Journalbeat is a lightweight journald log shipper for Elasticsearch."
pkg_upstream_url="https://github.com/elastic/beats/tree/master/journalbeat"

do_download() {
  SYSTEMD_INCLUDE_PATH=$(pkg_path_for core/systemd)/include
  GOPATH="$(dirname "${HAB_CACHE_SRC_PATH}")"
  export GOPATH
  rm -rf "${GOPATH}/src/github.com/elastic/beats"
  git clone https://github.com/elastic/beats "${GOPATH}"/src/github.com/elastic/beats
  pushd "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/journalbeat" > /dev/null
  git checkout "v${pkg_version}"
  popd > /dev/null
}

do_build() {
  SYSTEMD_INCLUDE_PATH=$(pkg_path_for core/systemd)/include
  pushd "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/journalbeat" > /dev/null
  CGO_CFLAGS="-I${SYSTEMD_INCLUDE_PATH}" make
  popd > /dev/null
}

do_install() {
  install -D "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/journalbeat/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
