pkg_name=goaccess
pkg_origin=core
pkg_version="1.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GoAccess is a real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser."
pkg_upstream_url="https://goaccess.io/"
pkg_license=("MIT")
pkg_source="https://github.com/allinurl/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="b231f23b7ae106da9e8aea34755a72891649b221dfb94cfab525e527829d5af7"
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/gawk
  core/gcc
  core/gettext
  core/make
)
pkg_deps=(
  core/glibc
  core/libmaxminddb
  core/ncurses
)
pkg_bin_dirs=(bin)

do_build() {
  autoreconf -fiv
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-utf8 \
    --enable-geoip=mmdb
  make
}

do_install() {
  do_default_install
  cp COPYING "${pkg_prefix}/"
}
