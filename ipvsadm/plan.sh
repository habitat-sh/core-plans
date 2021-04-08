pkg_name=ipvsadm
pkg_origin=core
pkg_version=1.31
pkg_description="Ipvsadm is used to set up, maintain or inspect the virtual server table in the Linux kernel."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_source="https://mirrors.edge.kernel.org/pub/linux/utils/kernel/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_upstream_url="http://www.linuxvirtualserver.org/software/ipvs.html"
pkg_shasum=1a0a5e25b5a1226435d2fb76341656f83a710183aebb0d204db39c0ec3bedfdb
pkg_deps=(
  core/glibc
  core/popt
  core/libnl
  core/bash
  core/grep
  core/coreutils
)
pkg_build_deps=(
  core/busybox-static
  core/make
  core/gcc
  core/pkg-config
  core/patch
)
pkg_bin_dirs=(bin)

do_build() {
  patch -p1 < "${PLAN_CONTEXT}/Makefile.patch"
  make
}

do_install() {
  install -m 0755 ipvsadm "${pkg_prefix}/bin"
  install -m 0755 ipvsadm-save "${pkg_prefix}/bin"
  install -m 0755 ipvsadm-restore "${pkg_prefix}/bin"

  fix_interpreter "${pkg_prefix}/bin/ipvsadm-save" core/bash bin/bash
  fix_interpreter "${pkg_prefix}/bin/ipvsadm-restore" core/bash bin/bash

  # Comment out the overridden paths
  sed -e '/^PATH/ s/^/#/' -i "${pkg_prefix}/bin/ipvsadm-save"
  sed -e '/^PATH/ s/^/#/' -i "${pkg_prefix}/bin/ipvsadm-restore"
}
