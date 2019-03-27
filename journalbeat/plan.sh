pkg_name=journalbeat
pkg_origin=core
pkg_version=6.7.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_deps=(core/glibc core/systemd)
pkg_build_deps=(
  core/go
  core/git
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root
pkg_description="Journalbeat is a lightweight journald log shipper for Elasticsearch."
pkg_upstream_url="https://github.com/elastic/beats/tree/master/journalbeat"

do_build() {
  SYSTEMD_INCLUDE_PATH=$(pkg_path_for core/systemd)/include
  GOPATH="$(dirname "${HAB_CACHE_SRC_PATH}")"
  export GOPATH
  CGO_CFLAGS="-I${SYSTEMD_INCLUDE_PATH}" go get github.com/elastic/beats/journalbeat
  pushd "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/journalbeat" > /dev/null || exit 1
  git checkout "v${pkg_version}"
  CGO_CFLAGS="-I${SYSTEMD_INCLUDE_PATH}" go build github.com/elastic/beats/journalbeat
  popd > /dev/null || exit 1
}

do_install() {
  install -D "${HAB_CACHE_SRC_PATH}/github.com/elastic/beats/journalbeat/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
