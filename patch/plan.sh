pkg_name=patch
pkg_origin=core
pkg_version=2.7.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Patch takes a patch file containing a difference listing produced by the diff \
program and applies those differences to one or more original files, producing \
patched versions.\
"
pkg_upstream_url="https://www.gnu.org/software/patch/"
pkg_license=('gplv3+')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="ac610bda97abe0d9f6b7c963255a11dcb196c25e337c61f94e4778d632f1d8fd"
pkg_deps=(
  core/glibc
  core/attr
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/make
  core/gcc
  core/sed
)
pkg_bin_dirs=(bin)

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
  pkg_build_deps=(
    core/gcc
    core/coreutils
    core/sed
    core/diffutils
    core/make
  )
fi
