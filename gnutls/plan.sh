pkg_name=gnutls
pkg_origin=core
pkg_version=3.6.16
pkg_description="GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them"
pkg_upstream_url="https://www.gnutls.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1-or-later')
pkg_source="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=1b79b381ac283d8b054368b335c408fedcb9b7144e0c07f531e3537d4328f3b3
pkg_deps=(
  core/glibc
  core/gmp
  core/guile
  core/libiconv
  core/libidn2
  core/libseccomp
  core/libtasn1
  core/libunistring
  core/nettle
  core/p11-kit
  core/zlib
)
pkg_build_deps=(
  core/autogen
  core/bison
  core/diffutils
  core/file
  core/gettext
  core/gcc
  core/iproute2
  core/make
  core/pkg-config
  core/which
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-libseccomp-prefix="$(pkg_path_for "core/libseccomp")" \
    --with-libiconv-prefix="$(pkg_path_for "core/libiconv")" \
    --with-libunistring-prefix="$(pkg_path_for "core/libunistring")" \
    --disable-valgrind-tests
  make -j"$(nproc)"
}

do_check() {
  # two tests fail
  # 1. a pkg config test which sets the PKG_CONFIG_PATH without nettle in it, would need to modify the test
  # 2. a libgcc_s.so.1 not found for one test, modifying LD_* variables does not seem to help
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
