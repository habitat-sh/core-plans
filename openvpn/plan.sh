pkg_name="openvpn"
pkg_origin="core"
pkg_version=2.4.7
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="OpenVPN provides flexible VPN solutions to secure your data communications"
pkg_license=('gplv2')
pkg_upstream_url="https://openvpn.net"
pkg_source=https://swupdate.openvpn.org/community/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum="73dce542ed3d6f0553674f49025dfbdff18348eb8a25e6215135d686b165423c"
pkg_deps=(core/glibc core/openssl core/lzo)
pkg_build_deps=(core/gcc core/coreutils core/make core/busybox-static)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_svc_user="root"
pkg_svc_group="${pkg_svc_user}"

do_build() {
  ./configure \
    --disable-plugin-auth-pam \
    --prefix="${pkg_prefix}" \
    --exec-prefix="${pkg_prefix}" \
    --sbindir="${pkg_prefix}/bin" \
    --enable-iproute2
  make
}
