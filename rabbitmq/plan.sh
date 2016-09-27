pkg_name=rabbitmq
pkg_distname=${pkg_name}-server
pkg_origin=core
pkg_version=3.6.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL')
pkg_description="Open source multi-protocol messaging broker"
pkg_upstream_url="https://www.rabbitmq.com"
pkg_source=http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.5/rabbitmq-server-3.6.5.tar.xz
pkg_shasum=9550433ca8aaf5130bf5235bb978c44d3c4694cbd09d97114b3859f4895788ec
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(core/glibc core/erlang)
pkg_build_deps=(core/bash core/python2 core/zip core/unzip core/git core/coreutils core/make core/gcc core/erlang core/libxslt core/libxml2 core/gawk core/diffutils core/perl core/grep core/rsync)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(sbin)
pkg_exposes=(5672)

do_prepare() {
  # The `/usr/bin/env` path is hardcoded, so we'll add a symlink if needed.
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

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

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
