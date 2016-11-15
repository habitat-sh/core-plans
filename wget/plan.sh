pkg_name=wget
pkg_distname="${pkg_name}"
pkg_origin=core
pkg_version=1.18
pkg_license=('gplv3+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://ftp.gnu.org/gnu/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.xz
pkg_shasum=b5b55b75726c04c06fe253daec9329a6f1a3c0c1878e3ea76ebfebc139ea9cc1
pkg_deps=(core/glibc core/libidn core/zlib core/openssl core/cacerts)
pkg_build_deps=(core/diffutils core/patch core/make core/gcc core/sed core/grep core/pkg-config)
pkg_bin_dirs=(bin)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-ssl=openssl \
    --without-libuuid
  make
}

do_install() {
  do_default_install

  echo "# Default root CA certs location" >> "${pkg_prefix}/etc/wgetrc"
  echo "ca_certificate=$(pkg_path_for cacerts)/ssl/certs/cacert.pem" >> "${pkg_prefix}/etc/wgetrc"
}

# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(core/gcc core/pkg-config core/coreutils core/sed core/grep core/diffutils core/make core/patch)
fi
