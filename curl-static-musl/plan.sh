pkg_name=curl-static-musl
pkg_distname=curl
pkg_origin=core
pkg_version=7.80.0
pkg_description="curl is an open source command line tool and library for transferring data with URL syntax."
pkg_upstream_url=https://curl.haxx.se/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('curl')
pkg_source="https://curl.haxx.se/download/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=dab997c9b08cb4a636a03f2f7f985eaba33279c1c52692430018fae4a4878dc7
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_deps=(
  core/cacerts
)
pkg_build_deps=(
	core/musl
	core/openssl-musl
	core/zlib-musl
	core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=()
pkg_lib_dirs=()

do_prepare() {
	export CC=musl-gcc
	build_line "Setting CC=${CC}"

	linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
	LDFLAGS="-static -Wl,--dynamic-linker=$linker $LDFLAGS"
	build_line "Setting LDFLAGS=${LDFLAGS}"
}

do_build() {
	./configure \
		--prefix="${pkg_prefix}" \
		--with-ca-bundle="$(pkg_path_for cacerts)/ssl/certs/cacert.pem" \
		--with-ssl="$(pkg_path_for openssl-musl)" \
		--with-zlib="$(pkg_path_for zlib-musl)" \
		--disable-manual \
		--disable-ldap \
		--disable-ldaps \
		--disable-rtsp \
		--enable-proxy \
		--enable-optimize \
		--disable-dependency-tracking \
		--enable-ipv6 \
		--without-libidn \
		--without-gnutls \
		--without-librtmp \
		--enable-static \
		--disable-shared
	make LDFLAGS="-all-static $LDFLAGS"
}

do_install() {
  make install
  # remove extraneous files - saves about 200kb in the compressed .hart
  rm -rf "${pkg_prefix:?}/bin/curl-config" "${pkg_prefix:?}/include" "${pkg_prefix:?}/lib" "${pkg_prefix:?}/share"
}
