pkg_name=httpd
pkg_origin=core
pkg_version=2.4.23
pkg_description="The Apache HTTP Server"
pkg_upstream_url="http://httpd.apache.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://archive.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=b71a13f56b8061c6b4086fdcc9ffdddd904449735eadec0f0e2947e33eec91d7
pkg_deps=(core/glibc core/expat core/libiconv core/apr core/apr-util core/pcre core/zlib core/openssl)
pkg_build_deps=(core/patch core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_expose=(80 443)
pkg_svc_run="bin/httpd -DFOREGROUND -f $pkg_svc_config_path/httpd.conf"
pkg_svc_user="root"

do_build() {
  ./configure --prefix="$pkg_prefix" \
              --with-expat="$(pkg_path_for expat)" \
              --with-iconv="$(pkg_path_for libiconv)" \
              --with-pcre="$(pkg_path_for pcre)" \
              --with-apr="$(pkg_path_for apr)" \
              --with-apr-util="$(pkg_path_for apr-util)" \
              --with-z="$(pkg_path_for zlib)" \
              --enable-ssl --with-ssl="$(pkg_path_for openssl)" \
              --enable-modules=most --enable-mods-shared=most
  make
}
