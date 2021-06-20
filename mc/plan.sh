pkg_name=mc
pkg_origin=core
pkg_version=4.8.26
pkg_description="Midnight Commander."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.midnight-commander.org/mc-${pkg_version}.tar.xz
pkg_upstream_url=https://www.midnight-commander.org
pkg_shasum=c6deadc50595f2d9a22dc6c299a9f28b393e358346ebf6ca444a8469dc166c27
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
