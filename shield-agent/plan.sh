pkg_name=shield-agent
pkg_origin=core
pkg_version="0.10.9"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="A standalone system that can perform backup and restore functions for a wide variety of pluggable data systems."
pkg_upstream_url="https://github.com/starkandwayne/shield"
pkg_source="https://github.com/starkandwayne/shield/archive/v${pkg_version}.tar.gz"
pkg_shasum=dbea689596bc496e2f16f8a4bf2aaade8fb693b3934f11b5b7e956573ebbc599
pkg_dirname="shield-${pkg_version}"

pkg_deps=(
  core/bash
  core/bzip2
  core/cacerts
  core/coreutils
  core/curl
  core/glibc
  core/jq-static
  core/libarchive
)
pkg_build_deps=(
  core/gcc
  core/git
  core/go
  core/gox
  core/make
)

pkg_bin_dirs=(bin)

pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

pkg_binds_optional=(
  [daemon]="port provisioning_key"
)

pkg_svc_user="root"
pkg_svc_group="$pkg_svc_user"

do_begin() {
  export SHIELD_SRC_PATH="${HAB_CACHE_SRC_PATH}/$pkg_dirname/src/github.com/starkandwayne/shield"
  export GOPATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_prepare() {
  rm -rf "${HAB_CACHE_SRC_PATH}/shield"
  mkdir -p "${HAB_CACHE_SRC_PATH}/shield"
  mv "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/"* "${HAB_CACHE_SRC_PATH}/shield/"

  mkdir -p "${SHIELD_SRC_PATH}"
  mv "${HAB_CACHE_SRC_PATH}/shield/"* "${SHIELD_SRC_PATH}"

  export PATH="$PATH:$GOPATH/bin"

  git config --global url."git://github.com/".insteadOf "https://github.com/"
  go get github.com/kardianos/govendor
  go install github.com/kardianos/govendor
}

do_build() {
  export VERSION="${pkg_version}"
  cd "${SHIELD_SRC_PATH}" || exit
  make release
}

do_install() {
  cd "${SHIELD_SRC_PATH}/artifacts" || exit
  tar -xvzf shield-server-linux-amd64.tar.gz
  cd shield-server-linux-amd64 || exit

  cp cli/shield           "${pkg_prefix}/bin"
  cp agent/shield-agent   "${pkg_prefix}/bin"
  cp -R plugins            "${pkg_prefix}/plugins"
  cp daemon/shield-pipe   "${pkg_prefix}/bin"
  fix_interpreter "${pkg_prefix}/bin/shield-pipe" core/bash bin/bash
}
