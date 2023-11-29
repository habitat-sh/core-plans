pkg_origin=core
pkg_name=openssh
pkg_version=7.9p1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Provides OpenSSH client and server."
pkg_license=('bsd')
pkg_source=http://mirror.wdc1.us.leaseweb.net/openbsd/OpenSSH/portable/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=6b4b3ba2253d84ed3771c8050728d597c91cfce898713beb7b64a305b6f11aad
pkg_upstream_url=https://www.openssh.com/
pkg_bin_dirs=(bin sbin libexec)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_deps=(core/glibc core/openssl core/zlib)
pkg_build_deps=(core/coreutils core/gcc core/make)
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --sysconfdir="${pkg_svc_path}/config" \
              --localstatedir="${pkg_svc_path}/var" \
              --datadir="${pkg_svc_data_path}" \
              --with-privsep-user=hab \
              --with-privsep-path="${pkg_prefix}/var/empty" \
	      --without-zlib-version-check
  make
}

do_install() {
  make install-nosysconf
}
