pkg_name=systemd
pkg_origin=core
pkg_version=243
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="systemd is an init system used in Linux distributions to \
bootstrap the user space. Subsequently to booting, it is used to manage system \
processes."
pkg_license=('GPL-2.0-only' 'LGPL-2.1-or-later')
pkg_source="https://github.com/systemd/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_upstream_url="https://github.com/systemd/systemd"
pkg_shasum=0611843c2407f8b125b1b7cb93533bdebd4ccf91c99dffa64ec61556a258c7d1
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(
  lib
  var/lib
  usr/lib
)
pkg_deps=(
  core/glibc
  core/libcap
  core/lz4
  core/util-linux
  core/xz
)
pkg_svc_user=root
pkg_svc_group=root
pkg_build_deps=(
  core/coreutils
  core/dbus
  core/gcc
  core/gettext
  core/gperf
  core/m4
  core/meson
  core/ninja
  core/pkg-config
)

do_prepare() {
  if [[ ! -f /usr/bin/env ]]; then
    ln -s "$(pkg_path_for core/coreutils)/bin/env" /usr/bin/env
  fi

  export LANG=en_US.utf8
  export LC_ALL=en_US.utf8
  # Systemd needs itself in rpath
  export LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/lib:${pkg_prefix}/lib/systemd"
}

do_build() {
  # meson_options.txt
  local meson_opts=(
    "--prefix=${pkg_prefix}"
    "-Dman=false"
    "-Dhtml=false"
    "-Dpython=false"
    "-Drootprefix=${pkg_prefix}"
    "-Drootlibdir=${pkg_prefix}/lib"
    "-Ddbuspolicydir=${pkg_prefix}/etc/dbus-1/system.d"
    "-Ddbussessionservicedir=${pkg_prefix}/etc/dbus-1/services"
    "-Ddbussystemservicedir=${pkg_prefix}/etc/dbus-1/system-services"
    "-Dtests=false"
  )
  meson build "${meson_opts[@]}"
  ninja -C build
}

do_install() {
  ninja -C build install
}
