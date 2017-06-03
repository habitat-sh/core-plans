pkg_name=dbus
pkg_origin=core
pkg_version="1.10.18"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPLv2')
pkg_description="D-Bus is a message bus system, a simple way for applications to talk to one another."
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/dbus/"
pkg_source="https://dbus.freedesktop.org/releases/dbus/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="6049ddd5f3f3e2618f615f1faeda0a115104423a7996b7aa73e2f36e38cc514a"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/make
  core/gcc
  core/expat
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
