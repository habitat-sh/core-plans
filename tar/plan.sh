pkg_name=tar
pkg_origin=core
pkg_version=1.29
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation."
pkg_upstream_url=https://www.gnu.org/software/tar/
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=cae466e6e58c7292355e7080248f244db3a4cf755f33f4fa25ca7f9a7ed09af0
pkg_deps=(core/glibc core/acl core/attr)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/sed)
pkg_bin_dirs=(bin)

do_build() {
  # * `FORCE_UNSAFE_CONFIGURE` forces the test for `mknod` to be run as root
  FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix="$pkg_prefix"
  make
}

do_check() {
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
  pkg_build_deps=(core/gcc core/coreutils core/sed)
fi
