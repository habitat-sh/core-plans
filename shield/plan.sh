pkg_name=shield
pkg_origin=core
pkg_version="0.10.8"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="A standalone system that can perform backup and restore functions for a wide variety of pluggable data systems."
pkg_upstream_url="https://github.com/starkandwayne/shield"
pkg_source="https://github.com/starkandwayne/shield/archive/v${pkg_version}.tar.gz"
pkg_shasum="1d9f5c80f86d6e1d8e0971959068154dd7f5299f307e06b38c33f63f81ee413a"

pkg_deps=(core/bash core/glibc core/postgresql core/shield-proxy/${pkg_version})
pkg_build_deps=(core/go core/git core/gcc core/make core/gox)

pkg_bin_dirs=(bin)

pkg_exports=(
  [port]=port
  [http_port]=http_port
  [provisioning_key]=auth.provisioning_key
)
pkg_exposes=(http_port port)

pkg_svc_user=root
pkg_svc_group="$pkg_svc_user"

pkg_binds=(
  [database]="port superuser_name superuser_password"
)

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
  go get github.com/tools/godep
  cd "${SHIELD_SRC_PATH}" || exit
  make restore-deps
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
  cp daemon/shieldd       "${pkg_prefix}/bin"
  cp daemon/shield-schema "${pkg_prefix}/bin"
  cp -R webui             "${pkg_prefix}/webui"
}
