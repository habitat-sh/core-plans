pkg_name=goaccess
pkg_origin=core
pkg_version="1.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GoAccess is a real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser."
pkg_upstream_url="https://goaccess.io/"
pkg_license=("MIT")
pkg_source="https://github.com/allinurl/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="daa38c3740a7d7c4f93ab31459ef44e68ab2d813f7507eed4e8f06ee03f3ba92"
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/gawk
  core/gcc
  core/make
)
pkg_deps=(
  core/glibc
  core/geoip
  core/ncurses
)

do_build() {
  autoreconf -fiv
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-utf8 \
    --enable-geoip=legacy
  make
}

do_install() {
  do_default_install
  cp COPYING "${pkg_prefix}/"
}
