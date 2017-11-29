pkg_name=kibana
pkg_version=6.0.0
pkg_origin=core
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Kibana is a browser based analytics and search dashboard for Elasticsearch."
pkg_upstream_url=https://www.elastic.co/products/kibana
pkg_source=https://github.com/elastic/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=85778c3d09bdc68369f37b887b4295d62e030ec29bf81c9f6bd17f0494177d56
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(core/node)
pkg_build_deps=(
  core/cacerts
  core/coreutils
  core/gcc
  core/git
  core/make
  core/node
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
  # The `/usr/bin/env` path is hardcoded in some node modules, so we'll add a
  # symlink if needed.
  if [[ ! -r /usr/bin/env ]]; then
    ln -svf "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi

  # Make sure git has CA certs when downloading
  git config --global http.sslCAInfo "$(pkg_path_for cacerts)/ssl/certs/cacert.pem"

  npm config set progress=false
}

do_build () {
  npm install
}

do_install() {
  cp -r ./* "${pkg_prefix}/"
  # Delete the /config directory created by Kibana installer; habitat lays down
  # /config/kibana.yml
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
