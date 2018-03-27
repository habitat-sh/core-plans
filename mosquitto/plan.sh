pkg_name=mosquitto
pkg_origin=core
pkg_version="1.4.15"
pkg_upstream_url="https://mosquitto.org"
pkg_description="An Open Source MQTT v3.1/v3.1.1 Broker"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('EPL-1.0' 'Eclipse Distribution License - v 1.0')
pkg_source="http://mosquitto.org/files/source/mosquitto-${pkg_version}.tar.gz"
pkg_shasum="7d3b3e245a3b4ec94b05678c8199c806359737949f4cfe0bf936184f6ca89a83"
pkg_deps=(
  core/bash
  core/c-ares
  core/gcc-libs
  core/glibc
  core/openssl
  core/util-linux
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_svc_run="mosquitto -c $pkg_svc_config_path/mosquitto.conf"

do_prepare() {
    sed -i'' "s#prefix=/usr/local#prefix=#" config.mk
    export DESTDIR="${pkg_prefix}"
}

do_build() {
    make
}

do_install() {
    do_default_install

    sources=$HAB_CACHE_SRC_PATH/${pkg_dirname}
    cp "$sources/edl-v10" "$sources/epl-v10" "$pkg_prefix"
}
