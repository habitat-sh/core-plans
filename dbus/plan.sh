pkg_name=dbus
pkg_origin=core
pkg_version="1.13.8"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPLv2')
pkg_description="D-Bus is a message bus system, a simple way for applications to talk to one another."
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/dbus/"
pkg_source="https://dbus.freedesktop.org/releases/dbus/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="82a89f64e1b55e459725186467770995f33cac5eb8a050b5d8cbeb338078c4f6"
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
