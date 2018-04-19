pkg_name=openvpn
pkg_origin=core
pkg_version=2.4.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_description="OpenVPN is an open source VPN daemon"
pkg_upstream_url="https://openvpn.net/"
pkg_source="https://swupdate.openvpn.org/community/releases/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="738dbd37fcf8eb9382c53628db22258c41ba9550165519d9200e8bebaef4cbe2"
pkg_deps=(
  core/glibc
  core/lz4
  core/lzo
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/busybox-static
  core/coreutils
  core/cmake
  core/file
  core/gcc
  core/git
  core/make
  core/pkg-config
)
pkg_bin_dirs=(sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure \
    --disable-plugin-auth-pam \
    --prefix"=${pkg_prefix}" \
    --enable-iproute2
  make
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
