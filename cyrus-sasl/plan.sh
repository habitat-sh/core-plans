pkg_origin=core
pkg_name=cyrus-sasl
pkg_version=2.1.27
pkg_description="Cyrus Simple Authentication Service Layer (SASL) library"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("custom") # 4-Clause-BSD-like, see http://www.cyrusimap.org/mediawiki/index.php/Downloads#Licensing
pkg_upstream_url=http://www.cyrusimap.org/
pkg_source=https://ftp.osuosl.org/pub/blfs/conglomeration/cyrus-sasl/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5
pkg_deps=(core/glibc core/openssl)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --with-plugindir="${pkg_prefix}/lib/sasl2" \
              --enable-auth-sasldb \
              --with-saslauthd="${pkg_svc_var_path}/run/saslauthd"
  make
}

do_install() {
  make install
  install -m644 COPYING "${pkg_prefix}/share/"
}
