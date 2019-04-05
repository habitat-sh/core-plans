pkg_name=kibana
pkg_version=6.5.4
pkg_origin=core
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Kibana is a browser based analytics and search dashboard for Elasticsearch."
pkg_upstream_url="https://www.elastic.co/products/kibana"
pkg_source="https://github.com/elastic/${pkg_name}.git"
pkg_shasum=2c966a0f0c99d60816fdd056d49a9c7fed782c48e64e15e66ede81a244c807a2
pkg_deps=(core/node8/8.14.0)
pkg_build_deps=(
  core/cacerts
  core/coreutils
  core/gcc
  core/git
  core/make
  core/yarn
  core/node8/8.14.0
  core/python2
)
pkg_exports=(
  [port]=server.port
)
pkg_exposes=(port)
pkg_binds_optional=(
  [elasticsearch]="http-port"
)
pkg_bin_dirs=(bin)

do_prepare() {
  # The `/usr/bin/env` path is hardcoded in some node modules
  # so we'll add a symlink if needed.
  if [[ ! -r /usr/bin/env ]]; then
    ln -svf "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi

  # Make sure git has CA certs when downloading
  git config --global http.sslCAInfo "$(pkg_path_for cacerts)/ssl/certs/cacert.pem"

  #npm config set progress=false
}

do_download() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO

  REPO_PATH="${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
  rm -rf "${REPO_PATH}"
  git clone "${pkg_source}" "${REPO_PATH}"
  pushd "${REPO_PATH}" || exit 1
  git checkout "tags/v${pkg_version}"
  popd || exit 1
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

do_build () {
  pushd "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}" || exit 1
  yarn kbn bootstrap
  yarn build --skip-os-packages
  popd || exit 1
}

do_install() {
  cp -r ./* "${pkg_prefix}/"
  # Delete the /config directory created by Kibana installer
  # Habitat creates /config/kibana.yml
  rm -rv "${pkg_prefix}/config/"
}

do_strip() {
  return 0
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
