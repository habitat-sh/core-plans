pkg_name=cockroach
pkg_origin=core
pkg_version=19.1.3
pkg_description="CockroachDB is a cloud-native SQL database for building global, scalable cloud services that survive disasters."
pkg_upstream_url=https://github.com/cockroachdb/cockroach
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://binaries.cockroachdb.com/cockroach-v${pkg_version}.src.tgz"
pkg_shasum=65e4c4ebb9c31a0d4e0522ad62d1f95663e594b05227ccedc7b05271bd5fd34a
pkg_dirname="${pkg_name}-v${pkg_version}"
pkg_build_deps=(
  core/autoconf
  core/cmake
  core/coreutils
  core/diffutils
  core/go
  core/gcc
  core/git
  core/libedit
  core/make
  core/procps-ng
  core/which
)
pkg_deps=(
  core/chrony
  core/gcc-libs
  core/glibc
  core/ncurses
)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port]="port"
  [http-port]="http-port"
  [region]="locality.region"
  [datacenter]="locality.datacenter"
  [ca_cert]="certs.ca_cert"
)
pkg_exports=(
  [port]=port
  [http-port]=http-port
)

do_prepare() {
  # The `/usr/bin/env` path is hardcoded in scripts, so we'll add a symlink since we don't want coreutils in prod.
  mkdir -p /usr/bin
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  export LIBRARY_PATH="${LD_RUN_PATH}"
  make --jobs="$(nproc)" buildoss
}

do_install() {
  pushd "./src/github.com/cockroachdb/cockroach" > /dev/null
  cp -v cockroachoss bin/* "${pkg_prefix}/bin/"
  popd > /dev/null
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
