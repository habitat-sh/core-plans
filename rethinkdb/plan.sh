pkg_name=rethinkdb
pkg_origin=core
pkg_version=2.3.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The open-source database for the realtime web."
pkg_upstream_url="https://rethinkdb.com"
pkg_license=('Apache-2.0')
pkg_source="https://download.${pkg_name}.com/dist/${pkg_name}-${pkg_version}.tgz"
pkg_shasum=dd8aeee169b177179bfe080725f0560443e0f26dae875b32ae25d90cf2f8ee10
pkg_build_deps=(
  core/gcc
  core/make
  core/python2
  core/boost
  core/coreutils
  core/node/4.2.6
  core/jemalloc
  core/m4
)
pkg_deps=(
  core/openssl
  core/gcc-libs
  core/protobuf
  core/zlib
  core/curl
  core/ncurses
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_exports=(
  [http-port]=http-port
  [driver-port]=driver-port
  [cluster-port]=cluster-port
)
pkg_exposes=(http-port driver-port cluster-port)
pkg_binds_optional=(
  [rethinkdb]="cluster-port"
)

do_prepare() {
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  export ALLOW_WARNINGS=1
  ./configure --prefix="${pkg_prefix}" --allow-fetch

  make -j"$(nproc)"
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
