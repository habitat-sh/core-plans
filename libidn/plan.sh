pkg_name=libidn
pkg_origin=core
pkg_version=1.33
pkg_license=('LGPL-2.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications"
pkg_upstream_url="https://www.gnu.org/software/libidn/"
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="44a7aab635bb721ceef6beecc4d49dfd19478325e1b47f3196f7d2acc4930e19"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/file
  core/patch
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
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
  pkg_build_deps=(core/gcc core/coreutils core/diffutils core/make core/patch core/file)
fi
