pkg_name=gnupg
pkg_distname=$pkg_name
pkg_origin=core
pkg_version="1.4.23"
pkg_license=('GPL-3.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP)"
pkg_upstream_url="https://gnupg.org/"
pkg_source="https://gnupg.org/ftp/gcrypt/gnupg/gnupg-${pkg_version}.tar.bz2"
pkg_shasum="c9462f17e651b6507848c08c430c791287cd75491f8b5a8b50c6ed46b12678ba"
pkg_deps=(core/glibc core/zlib core/bzip2 core/readline)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/sed core/findutils)
pkg_bin_dirs=(bin)

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --sbindir="$pkg_prefix/bin"
  make
}

do_check() {
  find tests -type f -print0 \
    | xargs -0 sed -e "s,/bin/pwd,$(pkg_path_for coreutils)/bin/pwd,g" -i

  make check
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(core/gcc core/coreutils core/sed core/diffutils core/findutils core/make core/patch)
fi
