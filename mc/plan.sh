pkg_name=mc
pkg_origin=core
pkg_version=4.8.27
pkg_description="Midnight Commander."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.midnight-commander.org/mc-${pkg_version}.tar.xz
pkg_upstream_url=https://www.midnight-commander.org
pkg_shasum=31be59225ffa9920816e9a8b3be0ab225a16d19e4faf46890f25bdffa02a4ff4
pkg_deps=(
  core/glib
  core/glibc
  core/ncurses
  core/pcre
)
pkg_build_deps=(
  core/check
  core/coreutils
  core/diffutils
  core/gcc
  core/gettext
  core/make
  core/perl
  core/pkg-config
)
pkg_bin_dirs=(bin)

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-screen=ncurses \
    --with-ncurses-libs="$(pkg_path_for ncurses)/lib" \
    --without-subshell \
    --without-x \
    --without-gpm-mouse
  make
}
