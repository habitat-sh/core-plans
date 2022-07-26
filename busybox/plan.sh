pkg_name=busybox
_distname="$pkg_name"
pkg_origin=core
pkg_version=1.34.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
BusyBox is the Swiss Army Knife of embedded Linux. BusyBox combines tiny \
versions of many common UNIX utilities into a single small executable. It \
provides replacements for most of the utilities you usually find in GNU \
fileutils, shellutils, etc.\
"
pkg_upstream_url="https://www.busybox.net/"
pkg_license=('GPL-2.0-only')
pkg_source="http://www.busybox.net/downloads/${_distname}-${pkg_version}.tar.bz2"
pkg_shasum="415fbd89e5344c96acf449d94a6f956dbed62e18e835fc83e064db33a34bd549"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/bash
  core/bison
  core/coreutils
  core/diffutils
  core/findutils
  core/flex
  core/gawk
  core/gcc
  core/gettext
  core/grep
  core/gzip
  core/libtool
  core/make
  core/patch
  core/sed
  core/texinfo
  core/util-linux
  core/wget
  core/xz
)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/ash bin/awk bin/env bin/sh bin/bash)

do_prepare() {
  _create_config
}

do_build() {
  make -j"$(nproc)"
}

do_install() {
  install -Dm755 busybox "$pkg_prefix/bin/busybox"

  # Check that busybox executable is not failing
  "$pkg_prefix"/bin/busybox >/dev/null

  # Generate the symlinks back to the `busybox` executable
  for l in $(busybox --list); do
    ln -sv busybox "$pkg_prefix/bin/$l"
  done
}

_create_config() {
  # To update to a new version,
  # Add an "attach" statement in the do_prepare block
  # build busybox
  # when it stops at the attach statement, then
  # run `make defconfig` to generate a new
  # `.config` file
  # then ctrl+c out of the build
  # then copy /hab/cache/src/busybox-version/.config
  # to core-plans/busybox/config.new
  # then compare core-plans/busybox/config to core-plans/busybox/config.new
  # and resolve any differences
  build_line "Customizing busybox configuration..."
  make defconfig
  sed --in-place=.bak \
    -e "s,CONFIG_PID_FILE_PATH=\"/var/run\",CONFIG_PID_FILE_PATH=\"$pkg_svc_var_path\",g" \
    -e "s,CONFIG_BUSYBOX_EXEC_PATH=\"/proc/self/exe\",CONFIG_BUSYBOX_EXEC_PATH=\"$pkg_prefix/bin/busybox\",g" \
    -e "s,CONFIG_EXTRA_CFLAGS=\"\",CONFIG_EXTRA_CFLAGS=\"$CFLAGS\",g" \
    -e "s,CONFIG_EXTRA_LDFLAGS=\"\",CONFIG_EXTRA_LDFLAGS=\"$LDFLAGS\",g" \
    -e "s,CONFIG_PREFIX=\"./_install\",CONFIG_PREFIX=\"$pkg_prefix\",g" \
    -e "s,CONFIG_UNAME_OSNAME=\"GNU/Linux\",CONFIG_UNAME_OSNAME=\"Habitat\",g" \
    -e "s,# CONFIG_NOLOGIN_DEPENDENCIES is not set,CONFIG_NOLOGIN_DEPENDENCIES=y,g" \
    -e "s,# CONFIG_FEATURE_DC_LIBM is not set,CONFIG_FEATURE_DC_LIBM=y,g" \
    -e "s,# CONFIG_BASH_IS_ASH is not set,CONFIG_BASH_IS_ASH=y,g" \
    -e "s,# CONFIG_BASH_IS_ASH is not set,CONFIG_BASH_IS_ASH=y,g" \
    -e "s,CONFIG_BASH_IS_NONE=y,# CONFIG_BASH_IS_NONE is not set,g" \
    .config
}
