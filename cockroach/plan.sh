pkg_name=cockroach
pkg_origin=core
<<<<<<< HEAD
pkg_version=2.1.3
=======
pkg_version=2.1.2
>>>>>>> 7d33110a... Update Cockroach version
pkg_description="CockroachDB is a cloud-native SQL database for building global, scalable cloud services that survive disasters."
pkg_upstream_url=https://github.com/cockroachdb/cockroach
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://binaries.cockroachdb.com/cockroach-v${pkg_version}.src.tgz
<<<<<<< HEAD
pkg_shasum=16d851a131e17002af04ad56e4adfec8182bf5ec55496ef2fcefe0461e16933e
=======
pkg_shasum=36f2dcf487d18c76471bdf7eff48c0ff4a4355026e1a06739cc388a711c99769
>>>>>>> 7d33110a... Update Cockroach version
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
pkg_binds_optional=(
  [cockroach]="port"
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
  make buildoss
}

do_install() { 
  pushd "./src/github.com/cockroachdb/cockroach" > /dev/null
<<<<<<< HEAD
  cp -v bin/* "${pkg_prefix}/bin/"
  cp -v cockroachoss "${pkg_prefix}/bin/cockroach"
=======
  cp -v cockroachoss bin/* "${pkg_prefix}/bin/"
>>>>>>> 7d33110a... Update Cockroach version
  popd > /dev/null
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
