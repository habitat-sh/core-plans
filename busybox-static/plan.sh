source ../busybox/plan.sh

pkg_name=busybox-static
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
BusyBox is the Swiss Army Knife of embedded Linux. BusyBox combines tiny \
versions of many common UNIX utilities into a single small executable. It \
provides replacements for most of the utilities you usually find in GNU \
fileutils, shellutils, etc.\
"
pkg_upstream_url="https://www.busybox.net/"
pkg_license=('gplv2')
pkg_deps=()
pkg_build_deps=(
  core/linux-headers-musl
  core/musl
  "${pkg_build_deps[@]}"
)
pkg_dirname=${_distname}-${pkg_version}

do_prepare() {
  CFLAGS="-I$(pkg_path_for linux-headers-musl)/include -I$(pkg_path_for musl)/include"
  build_line "Overriding CFLAGS=$CFLAGS"

  PLAN_CONTEXT="$PLAN_CONTEXT/../busybox" _create_config
  sed \
    -e '/CONFIG_STATIC/ s,^.*$,CONFIG_STATIC=y,' \
    -e '/CONFIG_FEATURE_UTMP/ s,^.*$,CONFIG_FEATURE_UTMP=n,' \
    -e '/CONFIG_FEATURE_WTMP/ s,^.*$,CONFIG_FEATURE_WTMP=n,' \
    -e '/CONFIG_INETD/ s,^.*$,CONFIG_INETD=n,' \
    -i .config

  sed '1,1i#include <sys/resource.h>' -i include/libbb.h
}

do_build() {
  make -j"$(nproc)" CC=musl-gcc
}
