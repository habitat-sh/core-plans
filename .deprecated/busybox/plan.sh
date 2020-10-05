pkg_name=busybox
_distname="$pkg_name"
pkg_origin=core
pkg_version=1.31.0
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
pkg_shasum="0e4925392fd9f3743cc517e031b68b012b24a63b0cf6c1ff03cce7bb3846cc99"
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
  sed --unbuffered \
    -e "s,@pkg_prefix@,$pkg_prefix,g" \
    -e "s,@pkg_svc_var@,$pkg_svc_var_path,g" \
    -e "s,@cflags@,$CFLAGS,g" \
    -e "s,@ldflags@,$LDFLAGS,g" \
    -e "s,@osname@,Habitat,g" \
    -e "s,@bash_is_ash@,y,g" \
    "$PLAN_CONTEXT"/config \
    > .config
}
