pkg_name=rabbitmq
pkg_distname=${pkg_name}-server
pkg_origin=core
pkg_version=3.6.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL')
pkg_description="Open source multi-protocol messaging broker"
pkg_upstream_url="https://www.rabbitmq.com"
pkg_source=http://www.rabbitmq.com/releases/rabbitmq-server/v${pkg_version}/rabbitmq-server-${pkg_version}.tar.xz
pkg_shasum=395689bcf57fd48aed452fcd43ff9a992de40067d3ea5c44e14680d69db7b78e
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(core/glibc core/erlang)
pkg_build_deps=(core/bash core/python2 core/zip core/unzip core/git core/coreutils core/make core/gcc core/erlang core/libxslt core/libxml2 core/gawk core/diffutils core/perl core/grep core/rsync)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(sbin)
pkg_exposes=(5672)

do_build() {
  make
}

do_check() {
  make tests
}

do_install() {
  export PREFIX="${pkg_prefix}"
  export DESTDIR="${PREFIX}"
  export RMQ_ROOTDIR=""
  export RMQ_LIBDIR=""
  export RMQ_ERLAPP_DIR=""
  make install
}
