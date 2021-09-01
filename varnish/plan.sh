
pkg_name=varnish
pkg_origin=core
pkg_description="Varnish Cache"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="http://varnish-cache.org/"
pkg_license=('bsd')
pkg_version="5.2.1"
pkg_source="https://varnish-cache.org/_downloads/${pkg_name}-${pkg_version}.tgz"

pkg_shasum="b8452c9d78c16f78c8cfd1c1a1e696523bf64b7721c330150dcc0852459014b3"
pkg_deps=(
  core/bash
  core/gcc
  core/glibc
  core/ncurses
  core/pcre
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/docutils
  core/graphviz
  core/libedit
  core/libtool
  core/make
  core/pkg-config
  core/python2
  core/readline
  core/m4
  core/patch
  core/file
)

pkg_bin_dirs=(
  bin
  sbin
)
pkg_svc_user=(root)

pkg_exports=(
  [port]=frontend.port
)

do_setup_environment() {
  export LDFLAGS="$LDFLAGS -Wl,--copy-dt-needed-entries"
  export CURSES_LIB="-lcurses"
}

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi

  ACLOCAL_PATH="$ACLOCAL_PATH:$(pkg_path_for pkg-config)/share/aclocal"
  export ACLOCAL_PATH

  autoupdate
  ./autogen.sh

  # configure is mangled, for some reason
  patch < "$PLAN_CONTEXT"/patches/000-configure.patch
}

do_end() {
  if [[ -n "${_clean_file}" ]]; then
    rm -fv /usr/bin/file
  fi
}

do_after_failure() {
  do_end
}
