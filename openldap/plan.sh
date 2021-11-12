pkg_origin=core
pkg_name=openldap
pkg_version=2.6.0
pkg_description="Community developed LDAP software"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("OLDAP-2.8")
pkg_upstream_url=http://www.openldap.org/
pkg_source=https://www.openldap.org/software/download/OpenLDAP/${pkg_name}-release/${pkg_name}-${pkg_version}.tgz
pkg_shasum=b71c580eac573e9aba15d95f33dd4dd08f2ed4f0d7fc09e08ad4be7ed1e41a4f
pkg_deps=(core/glibc core/libtool core/db core/openssl11 core/cyrus-sasl)
pkg_build_deps=(core/gcc core/make core/groff)
pkg_bin_dirs=(bin sbin libexec)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

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
