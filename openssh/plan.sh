pkg_origin=core
pkg_name=openssh
pkg_version=7.5p1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Provides OpenSSH client and server."
pkg_license=('bsd')
pkg_source=https://cloudflare.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=9846e3c5fab9f0547400b4d2c017992f914222b3fd1f8eee6c7dc6bc5e59f9f0
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
              --with-privsep-path="${pkg_prefix}/var/empty"
  make
}

do_install() {
  make install-nosysconf
  mkdir -p "${pkg_prefix}/var/empty"
  chmod 700 "${pkg_prefix}/var/empty"
}
