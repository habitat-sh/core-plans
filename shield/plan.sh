pkg_name=shield
pkg_origin=core
pkg_version="0.10.9"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="A standalone system that can perform backup and restore functions for a wide variety of pluggable data systems."
pkg_upstream_url="https://github.com/starkandwayne/shield"
pkg_source="https://github.com/starkandwayne/shield/archive/v${pkg_version}.tar.gz"
pkg_shasum=dbea689596bc496e2f16f8a4bf2aaade8fb693b3934f11b5b7e956573ebbc599

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

do_before() {
  SHIELD_SRC_PATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}/src/github.com/starkandwayne/shield"
  export SHIELD_SRC_PATH
}

do_clean() {
  rm -rf "${SHIELD_SRC_PATH}"
}

do_unpack() {
  mkdir -p "${SHIELD_SRC_PATH}"
  tar xf "${pkg_filename}" -C "${SHIELD_SRC_PATH}" --strip-components 1
}

do_prepare() {
  GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  export GOPATH
  PATH="$PATH:$GOPATH/bin"
  export PATH
  VERSION="${pkg_version}"
  export VERSION
  GO111MODULE="off"
  export GO111MODULE

  git config --global url."git://github.com/".insteadOf "https://github.com/"
  pushd "${SHIELD_SRC_PATH}" &>/dev/null || exit 1
    go get github.com/kardianos/govendor
    go install github.com/kardianos/govendor
  popd || exit 1
}

do_build() {
  pushd "${SHIELD_SRC_PATH}" &>/dev/null || exit 1
    make release
  popd || exit 1
}

do_install() {
  tar xf "${SHIELD_SRC_PATH}"/artifacts/shield-server-linux-amd64.tar.gz -C "${pkg_prefix}" --strip-components 1
  ln -s "${pkg_prefix}"/cli/shield "${pkg_prefix}"/bin/shield
  ln -s "${pkg_prefix}"/daemon/shieldd "${pkg_prefix}"/bin/shieldd
  ln -s "${pkg_prefix}"/daemon/shield-schema "${pkg_prefix}"/bin/shield-schema
}
