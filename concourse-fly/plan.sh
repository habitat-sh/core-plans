pkg_name=concourse-fly
pkg_origin=core
pkg_version="4.2.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="Concourse CLI for interacting with the ATC API"
pkg_upstream_url="https://concourse.ci"
pkg_source="https://github.com/concourse/concourse.git"

pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/cacerts
  core/gnupg
  core/go
  core/git
  core/gcc
)
pkg_bin_dirs=(bin)

do_setup_environment() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO
  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
  export GO111MODULE=off
}

do_before() {
  rm -rf "$REPO_PATH"
}

do_download() {
  git clone "$pkg_source" "$REPO_PATH"
  pushd "$REPO_PATH" || return 1
    git checkout "tags/v${pkg_version}"
    git submodule update --init --recursive
  popd || return 1
}

do_unpack() {
  return 0
}

do_clean() {
  return 0
}

do_verify() {
  return 0
}

do_build(){
  source .envrc
  cd "$HAB_CACHE_SRC_PATH/$pkg_dirname/src/github.com/concourse/fly" || return 1
  go build
}

do_install(){
  cp "$HAB_CACHE_SRC_PATH/$pkg_dirname/src/github.com/concourse/fly/fly" "${pkg_prefix}/bin/fly"
}
