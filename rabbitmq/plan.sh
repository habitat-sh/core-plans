pkg_name=rabbitmq
pkg_distname=${pkg_name}-server
pkg_origin=core
pkg_version=3.7.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL')
pkg_description="Open source multi-protocol messaging broker"
pkg_upstream_url="https://www.rabbitmq.com"
pkg_source=https://github.com/rabbitmq/rabbitmq-server/releases/download/v${pkg_version}/rabbitmq-server-${pkg_version}.tar.xz
pkg_shasum=b88de3aea1ed5c4fc048cb310609fdfd430b2e4e6629e0efd9fc2a4327324fab
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(
  core/coreutils
  core/glibc
  core/erlang
)
pkg_build_deps=(
  core/bash
  core/diffutils
  core/elixir
  core/gawk
  core/gcc
  core/git
  core/grep
  core/libxml2
  core/libxslt
  core/make
  core/perl
  core/python2
  core/rsync
  core/unzip
  core/zip
  core/patchelf
)
pkg_include_dirs=(include)
pkg_bin_dirs=(sbin)
pkg_exports=(
  [port]=rabbitmq.listen_port
)

pkg_exposes=(port)

do_prepare() {
  export PREFIX="${pkg_prefix}"
  build_line "Setting PREFIX=$PREFIX"
  export DESTDIR="${PREFIX}"
  build_line "Setting DESTDIR=$DESTDIR"
  export RMQ_ROOTDIR=""
  build_line "Setting RMQ_ROOTDIR=$RMQ_ROOTDIR"
  export RMQ_LIBDIR=""
  build_line "Setting RMQ_LIBDIR=$RMQ_LIBDIR"
  export RMQ_ERLAPP_DIR=""
  build_line "Setting RMQ_ERLAPP_DIR=$RMQ_ERLAPP_DIR"
  export LC_ALL=en_US.UTF-8
}

do_build() {
  make
}

do_install() {
  do_default_install || return $?
  # Install tini, to reap zombie child process https://github.com/habitat-sh/core-plans/issues/1099
  curl -L -o ${pkg_prefix}/sbin/tini https://github.com/krallin/tini/releases/download/v0.16.1/tini-amd64
  chmod +x ${pkg_prefix}/sbin/tini
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" ${pkg_prefix}/sbin/tini
  return $?
}

do_check() {
  make tests
}
