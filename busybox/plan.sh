pkg_name=busybox
_distname="$pkg_name"
pkg_origin=core
pkg_version=1.28.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
BusyBox is the Swiss Army Knife of embedded Linux. BusyBox combines tiny \
versions of many common UNIX utilities into a single small executable. It \
provides replacements for most of the utilities you usually find in GNU \
fileutils, shellutils, etc.\
"
pkg_upstream_url="https://www.busybox.net/"
pkg_license=('gplv2')
pkg_source="http://www.busybox.net/downloads/${_distname}-${pkg_version}.tar.bz2"
pkg_shasum="98fe1d3c311156c597cd5cfa7673bb377dc552b6fa20b5d3834579da3b13652e"
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

  # Generate the symlinks back to the `busybox` executable
  for l in $("$pkg_prefix/bin/busybox" --list); do
    ln -sv busybox "$pkg_prefix/bin/$l"
  done
}

_create_config() {
  # To update to a new version, run `make defconfig` to generate a new
  # `.config` file and add the following replacement tokens below.
  build_line "Customizing busybox configuration..."
  # shellcheck disable=SC2002
  cat "$PLAN_CONTEXT/config" \
    | sed \
      -e "s,@pkg_prefix@,$pkg_prefix,g" \
      -e "s,@pkg_svc_var@,$pkg_svc_var_path,g" \
      -e "s,@cflags@,$CFLAGS,g" \
      -e "s,@ldflags@,$LDFLAGS,g" \
      -e "s,@osname@,Habitat,g" \
      -e "s,@bash_is_ash@,y,g" \
    > .config
}
