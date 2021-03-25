pkg_name=tlog
pkg_origin=core
pkg_version=11
pkg_description="Tlog is a terminal I/O recording and playback package suitable for implementing centralized user session recording."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0-or-later")
pkg_source="https://github.com/Scribery/tlog/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_upstream_url="https://github.com/Scribery/tlog"
pkg_shasum="3f181107cb3149b1d6cd238031acd7c61d0bf2c79463fa7272f411ee25918b53"

pkg_deps=(
  core/curl
  core/glibc
  core/json-c
  core/openssl
  core/systemd
  core/zlib
)

pkg_build_deps=(
  core/autoconf
  core/automake
  core/busybox-static
  core/curl
  core/file
  core/gcc
  core/json-c
  core/libtool
  core/m4
  core/make
  core/pkg-config
  core/systemd
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix="${pkg_prefix}" --sysconfdir="${pkg_prefix}/etc" --localstatedir="${pkg_svc_var_path}" && make
}
