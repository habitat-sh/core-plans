pkg_origin=core
pkg_name=cyrus-sasl
pkg_version=2.1.26
pkg_description="Cyrus Simple Authentication Service Layer (SASL) library"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("custom") # 4-Clause-BSD-like, see http://www.cyrusimap.org/mediawiki/index.php/Downloads#Licensing
pkg_upstream_url=http://www.cyrusimap.org/
pkg_source=ftp://ftp.cyrusimap.org/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=8fbc5136512b59bb793657f36fadda6359cae3b08f01fd16b3d406f1345b7bc3
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
