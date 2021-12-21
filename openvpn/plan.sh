pkg_name=openvpn
pkg_origin=core
pkg_version=2.5.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2')
pkg_upstream_url=https://openvpn.net
pkg_source=https://github.com/OpenVPN/openvpn/archive/refs/tags/v${pkg_version}.tar.gz
pkg_shasum=032dbeb31ebca1703d2aaeb516d9a66c3a1313ffcf4d145089df02bb14ad8a41
pkg_deps=(core/glibc core/openssl core/lzo)
pkg_build_deps=(core/gcc
	core/coreutils
       	core/make
       	core/busybox-static
	core/autoconf
	core/automake
	core/libtool
	core/docutils
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
	autoreconf -i -v -f -I$(pkg_path_for core/libtool)/share/aclocal
  ./configure \
    --disable-plugin-auth-pam \
    --prefix=${pkg_prefix} \
    --exec-prefix=${pkg_prefix} \
    --sbindir=${pkg_prefix}/bin \
    --enable-iproute2
  make
}
