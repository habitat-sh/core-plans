
pkg_name=varnish
pkg_origin=core
pkg_description="Varnish Cache"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="http://varnish-cache.org/"
pkg_license=('bsd')
pkg_version="5.1.2"
pkg_source="https://varnish-cache.org/_downloads/${pkg_name}-${pkg_version}.tgz"

pkg_shasum="39d858137e26948a7c85f07363f13f0778da61d234126e03a160a0cb9ba4fce3"
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
)

pkg_bin_dirs=(
  bin
  sbin
)
pkg_svc_user=(root)

pkg_exports=(
  [port]=frontend.port
)

do_begin() {
  return 0
}

do_prepare() {
  return 0
}

do_build() {
  # TODO: if we don't copy this aclocal will fail. need to figure out how to fix this
  cp "$(pkg_path_for core/pkg-config)/share/aclocal/pkg.m4" "$(pkg_path_for core/automake)/share/aclocal/"
  sh autogen.sh
  sh configure --prefix="$pkg_prefix"
  make
}

do_check() {
  return 0
}
