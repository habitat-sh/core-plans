pkg_name=rethinkdb
pkg_origin=core
pkg_version=2.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The open-source database for the realtime web."
pkg_upstream_url="https://rethinkdb.com"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/rethinkdb/rethinkdb/archive/refs/tags/v${pkg_version}.tar.gz"
pkg_shasum=fd77bd1a5ba5db9597264765da25ce8dd2a215fc1fe407a4bf1be8e71d1e1aa5
pkg_build_deps=(
  core/gcc
  core/make
  core/python2
  core/boost
  core/coreutils
  core/jemalloc
  core/m4
  core/patch
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
  cd "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
  patch -p1 < "$PLAN_CONTEXT/datum_endian_fix.patch" ./src/rdb_protocol/datum.cc
  patch -p1 < "$PLAN_CONTEXT/node_heap_fix.patch" ./mk/support/pkg/node.sh
  cp "$PLAN_CONTEXT/v8_4-gcc6+.patch" "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}/mk/support/pkg/patch/"
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
