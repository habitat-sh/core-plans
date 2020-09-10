source ../busybox/plan.sh

pkg_name=busybox-static
pkg_origin=core
pkg_version=1.31.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="BusyBox is the Swiss Army Knife of embedded Linux."
pkg_upstream_url=https://www.busybox.net/
pkg_license=("GPL-2.0-only")
pkg_deps=()
pkg_build_deps=(
  core/linux-headers-musl
  core/musl
  "${pkg_build_deps[@]}"
)
pkg_dirname="${_distname}-${pkg_version}"

do_prepare() {
  CFLAGS="-I$(pkg_path_for linux-headers-musl)/include -I$(pkg_path_for musl)/include"
  build_line "Overriding CFLAGS=${CFLAGS}"

  LDFLAGS="-g"
  build_line "Overriding LDFLAGS=${LDFLAGS}"

  PLAN_CONTEXT="${PLAN_CONTEXT}/../busybox" _create_config
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
