pkg_name=cockroach
pkg_origin=core
pkg_version=2.0.1
pkg_description="CockroachDB is a cloud-native SQL database for building global, scalable cloud services that survive disasters."
pkg_upstream_url=https://github.com/cockroachdb/cockroach
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://binaries.cockroachdb.com/cockroach-v${pkg_version}.src.tgz
pkg_shasum=4f929461ad50d3fd471886856aa399f41a405a664e886cf9ab71d2879162955e
pkg_dirname="${pkg_name}-v${pkg_version}"
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/ncurses
)
pkg_build_deps=(
  core/coreutils
  core/libedit
  core/make
  core/which
  core/go
  core/gcc
  core/cmake
  core/autoconf
)
pkg_bin_dirs=(bin)


do_prepare() {
  # The `/usr/bin/env` path is hardcoded in scripts, so we'll add a symlink since we don't want coreutils in prod.
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  export LIBRARY_PATH=$LD_RUN_PATH
  make buildoss
}

do_install() {
  pushd "./src/github.com/cockroachdb/cockroach" > /dev/null
  cp -v cockroach bin/* "${pkg_prefix}/bin/"
  popd > /dev/null
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
