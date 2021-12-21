pkg_name=rabbitmq
pkg_distname="${pkg_name}-server"
pkg_origin=core
pkg_version=3.9.11
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL')
pkg_description="Open source multi-protocol messaging broker"
pkg_upstream_url="https://www.rabbitmq.com"
pkg_source="https://github.com/rabbitmq/rabbitmq-server/releases/download/v${pkg_version}/rabbitmq-server-${pkg_version}.tar.xz"
pkg_shasum=88908f27293f2d86dc94c70567f26afc1849fc7c1e174510a6c3c0fca1d3f547
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_deps=(
  core/coreutils
  core/glibc
  core/erlang
)
pkg_build_deps=(
  core/bash
  core/diffutils
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
  core/elixir
)
pkg_include_dirs=(include)
pkg_bin_dirs=(sbin)
pkg_exports=(
  [port]=listeners.tcp.default
)
pkg_exposes=(port)

do_prepare() {
  export PREFIX="${pkg_prefix}"
  build_line "Setting PREFIX=${PREFIX}"
  export DESTDIR="${PREFIX}"
  build_line "Setting DESTDIR=${DESTDIR}"
  export RMQ_ROOTDIR=""
  build_line "Setting RMQ_ROOTDIR=${RMQ_ROOTDIR}"
  export RMQ_LIBDIR=""
  build_line "Setting RMQ_LIBDIR=${RMQ_LIBDIR}"
  export RMQ_ERLAPP_DIR=""
  build_line "Setting RMQ_ERLAPP_DIR=${RMQ_ERLAPP_DIR}"
  export LANG="en_US.utf8"
  export LANGUAGE="en_US:"
  export LC_ALL=en_US.UTF-8
  build_line "Setting locale to en_US.utf8"
}

do_build() {
  make
}

do_check() {
  make tests
}
