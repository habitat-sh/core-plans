pkg_name=dbus
pkg_origin=core
pkg_version="1.13.18"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPLv2')
pkg_description="D-Bus is a message bus system, a simple way for applications to talk to one another."
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/dbus/"
pkg_source="https://dbus.freedesktop.org/releases/dbus/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="8078f5c25e34ab907ce06905d969dc8ef0ccbec367e1e1707c7ecf8460f4254e"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/make
  core/expat
  core/gcc
  core/pkg-config
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
