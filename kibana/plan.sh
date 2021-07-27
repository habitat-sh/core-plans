pkg_name=kibana
pkg_version=6.8.14
pkg_origin=core
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Kibana is a browser based analytics and search dashboard for Elasticsearch."
pkg_upstream_url="https://www.elastic.co/products/${pkg_name}"
pkg_source="https://github.com/elastic/${pkg_name}"
pkg_deps=(core/node10 core/which)
pkg_build_deps=(
  core/cacerts
  core/coreutils
  core/gcc
  core/glibc
  core/git
  core/make
  core/sed
  core/python2
  core/pcre
  core/patch
  core/patchelf
  core/yarn
)
pkg_exports=(
  [port]=server.port
)
pkg_exposes=(port)
pkg_binds_optional=(
  [elasticsearch]="http-port"
)
pkg_bin_dirs=(bin)

do_download() {
  rm -rf "${SRC_PATH}"
  git clone --depth 1 --branch "v${pkg_version}" "${pkg_source}" "${SRC_PATH}"
}

do_verify() {
  return 0
}

do_clean() {
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
  # The `/usr/bin/env` path is hardcoded in some node modules, so we'll add a
  # symlink if needed.
  if [[ ! -r /usr/bin/env ]]; then
    ln -svf "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi

  if [[ ! -f /etc/os-release ]]; then
    touch /etc/os-release
    _clean_os_release=true
  fi

  # Make sure git has CA certs when downloading
  git config --global http.sslCAInfo "$(pkg_path_for cacerts)/ssl/certs/cacert.pem"

  npm config set progress=false

  local node_version=$(pcregrep -oM 'node10/\K([^/]+)' <<<"${pkg_deps_resolved[@]}")
  sed -i -e "s,\"node\": \"10.23.1\",\"node\": \"${node_version}\",g" package.json

  LD_RUN_PATH="${LD_RUN_PATH}:$(tr -d -- '-L' <<<$LDFLAGS| tr ' ' ':')"
  export LD_RUN_PATH
  build_line "Setting LD_RUN_PATH=${LD_RUN_PATH}"
}

do_build () {
  # https://github.com/elastic/kibana/blob/v6.8.14/CONTRIBUTING.md#setting-up-your-development-environment
  # https://github.com/elastic/kibana/tree/v6.8.14/packages/kbn-pm
  yarn kbn bootstrap

  # This build will fail as kibana will download it's own node
  # distributable to run the optimization procedure which will
  # not respect LD_RUN_PATH (throws error not found). Run
  # through the build to allow for the download/extraction
  # of this node (catching the error with || true), patch it
  # with patchelf, and patch the build files to not re-extract the
  # node archives
  yarn build --no-oss --skip-os-packages --skip-archives --release || true

  patch -p1 < "${PLAN_CONTEXT}/patches/000-extract-node.patch"
  patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    --set-rpath "${LD_RUN_PATH}" \
    .node_binaries/10.24.0/linux-x64/bin/node

  yarn build --no-oss --skip-os-packages --skip-archives --release
}

do_install() {
  cp -r build/default/kibana-${pkg_version}-linux-x86_64/* "${pkg_prefix}/"
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

  # Clean up `os-release`, if we set it up.
  if [[ -n "$_clean_os_release" ]]; then
    rm -fv /etc/os-release
  fi
}
