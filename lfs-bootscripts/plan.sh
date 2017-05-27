pkg_name=lfs-bootscripts
pkg_origin=core
pkg_version=20090812
pkg_source=http://www.linuxfromscratch.org/lfs/downloads/6.5/${pkg_name}-${pkg_version}.tar.bz2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The LFS-Bootscripts package contains a set of scripts to start/stop the LFS system at bootup/shutdown."
pkg_shasum="55adc9b32062a88e83c2ca40b035ab5cc9dc4cab811935496f29efc8bd0522e9"
pkg_upstream_url=http://www.linuxfromscratch.org/
pkg_license=('All rights reserved')
pkg_deps=(core/make core/busybox-static)

do_build() {
  return 0
}

do_install() {
  cp -a . "${pkg_prefix}"
}
