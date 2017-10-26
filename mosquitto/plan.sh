pkg_name=mosquitto
pkg_origin=core
pkg_version="1.4.14"
pkg_upstream_url="https://mosquitto.org"
pkg_description="An Open Source MQTT v3.1/v3.1.1 Broker"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('EPL-1.0' 'Eclipse Distribution License - v 1.0')
pkg_source="http://mosquitto.org/files/source/mosquitto-${pkg_version}.tar.gz"
pkg_shasum="156b1fa731d12baad4b8b22f7b6a8af50ba881fc711b81e9919ec103cf2942d1"
pkg_deps=(core/glibc core/gcc-libs core/openssl core/c-ares core/util-linux core/bash)
pkg_build_deps=(core/make core/gcc)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_svc_run="mosquitto -c $pkg_svc_config_path/mosquitto.conf"

do_prepare() {
    sed -i "s#prefix=/usr/local#prefix=#" config.mk
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
