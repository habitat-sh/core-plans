pkg_name=netdata
pkg_origin=core
pkg_version=1.17.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="netdata is a system for distributed real-time performance and health monitoring."
pkg_upstream_url="https://github.com/netdata/netdata"
pkg_source="https://github.com/netdata/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=2dc0d510a31655bab4c269b78e1619fcdce38bf79335966d61d6bbd7bed736c5
pkg_build_deps=(
  core/autoconf
  core/autogen
  core/automake
  core/pkg-config
  core/gcc
  core/make
)
pkg_deps=(
  core/bash
  core/curl
  core/gawk
  core/glibc
  core/python
  core/util-linux
  core/zlib
  core/coreutils
)
pkg_bin_dirs=(sbin)
pkg_exports=(
  [host]=server.address
  [port]=server.port
)
pkg_exposes=(port)
pkg_svc_run="netdata -D -c ${pkg_svc_config_path}/netdata.conf"

do_build() {
  # patch shell script shebang lines to use habitat-provided env
  fix_interpreter "./*.sh" core/coreutils bin/env

  ACLOCAL_PATH="$(pkg_path_for core/pkg-config)/share/aclocal" autoreconf -ivf
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-zlib \
    --with-math \
    --with-user="${pkg_svc_user}"

  make
}

do_install() {
  do_default_install || return $?

  pushd "${pkg_prefix}" > /dev/null

  rm -r "./var"

  build_line "Fixing libexec interpreters"
  find ./libexec/netdata -type f -executable \
    -print \
    -exec bash -c 'sed -e "s#\#\!/usr/bin/env bash#\#\!$1/bin/bash#" --in-place "$2"' _ "$(pkg_path_for bash)" "{}" \;

  popd > /dev/null
}
