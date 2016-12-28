pkg_origin=core
pkg_name=openldap
pkg_version=2.4.44
pkg_description="Community developed LDAP software"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("OLDAP-2.8")
pkg_upstream_url=http://www.openldap.org/
pkg_source=ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/${pkg_name}-${pkg_version}.tgz
pkg_shasum=d7de6bf3c67009c95525dde3a0212cc110d0a70b92af2af8e3ee800e81b88400
pkg_deps=(core/glibc core/libtool core/db core/openssl core/cyrus-sasl)
pkg_build_deps=(core/gcc core/make core/groff)
pkg_bin_dirs=(bin sbin libexec)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(10389)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --localstatedir="${pkg_svc_var_path}" \
              --enable-dynamic \
              --enable-local \
              --enable-proctitle \
              --enable-shared \
              --enable-ipv6 \
              --enable-slapd \
              --enable-crypt \
              --enable-modules \
              --enable-rewrite \
              --enable-rlookups \
              --enable-bdb \
              --enable-hdb \
              --enable-syncprov=yes \
              --enable-overlays=mod \
              --with-tls=openssl \
              --with-cyrus-sasl

  make depend
  make
}

do_check() {
  make test
}
