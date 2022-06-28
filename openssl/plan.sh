pkg_name=openssl
_distname="$pkg_name"
pkg_origin=core
pkg_version=1.0.2zb
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
OpenSSL is an open source project that provides a robust, commercial-grade, \
and full-featured toolkit for the Transport Layer Security (TLS) and Secure \
Sockets Layer (SSL) protocols. It is also a general-purpose cryptography \
library.\
"
pkg_upstream_url="https://www.openssl.org"
pkg_license=('OpenSSL')
pkg_source="https://s3.amazonaws.com/chef-releng/${_distname}/${_distname}-${pkg_version}.tar.gz"
pkg_shasum=b7d8f8c895279caa651e7f3de9a7b87b8dd01a452ca3d9327f45a9ef31d0c518
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
  core/cacerts
  core/openssl-fips
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
  core/grep
  core/perl
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

_common_prepare() {
  do_default_prepare

  # Set CA dir to `$pkg_prefix/ssl` by default and use the cacerts from the
  # `cacerts` package. Note that `patch(1)` is making backups because
  # we need an original for the test suite.
  # DO NOT REMOVE
  sed -e "s,@cacerts_prefix@,$(pkg_path_for cacerts),g" \
      "$PLAN_CONTEXT/ca_dir.patch" \
      | patch -p1 --backup

  if [[ ! -f "/bin/rm" ]]; then
    hab pkg binlink core/coreutils rm --dest /bin
    BINLINKED_RM=true
  fi
}

do_prepare() {
  _common_prepare

  export BUILD_CC=gcc
  build_line "Setting BUILD_CC=$BUILD_CC"
}

do_build() {
  # Set PERL var for scripts in `do_check` that use Perl
  PERL=$(pkg_path_for core/perl)/bin/perl
  export PERL
  "$(pkg_path_for core/perl)/bin/perl" ./Configure \
    no-idea \
    no-mdc2 \
    no-rc5 \
    no-sslv2 \
    no-sslv3 \
    no-comp \
    no-zlib \
    shared \
    disable-gost \
    --prefix="${pkg_prefix}" \
    --openssldir=ssl \
    linux-x86_64 \
    --with-fipsdir="$(pkg_path_for core/openssl-fips)" \
    fips \
    -DOPENSSL_TRUSTED_FIRST_DEFAULT

  make CC= depend
  make --jobs="$(nproc)" CC="$BUILD_CC"
}

do_check() {
  # Flip back to the original sources to satisfy the test suite, but keep the
  # final version for packaging.
  for f in apps/CA.pl.in apps/CA.sh apps/openssl.cnf; do
    cp -fv $f ${f}.final
    cp -fv ${f}.orig $f
  done

  make test

  # Finally, restore the final sources to their original locations.
  for f in apps/CA.pl.in apps/CA.sh apps/openssl.cnf; do
    cp -fv ${f}.final $f
  done
}

do_install() {
  do_default_install

  # Remove dependency on Perl at runtime
  rm -rfv "$pkg_prefix/ssl/misc" "$pkg_prefix/bin/c_rehash"
}

do_end() {
  do_default_end

  # Clean up binlinked rm if we made it
  if [[ $BINLINKED_RM == true ]]; then
    rm -f /bin/rm
  fi
}

# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    core/gcc
    core/coreutils
    core/sed
    core/grep
    core/perl
    core/diffutils
    core/make
    core/patch
  )
fi
