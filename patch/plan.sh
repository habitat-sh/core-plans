# Disable shellcheck that would require quotes around pkg_name
# shellcheck disable=SC2209
pkg_name=patch
pkg_origin=core
pkg_version=2.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Patch takes a patch file containing a difference listing produced by the diff \
program and applies those differences to one or more original files, producing \
patched versions.\
"
pkg_upstream_url="https://www.gnu.org/software/patch/"
pkg_license=('GPL-3.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="f87cee69eec2b4fcbf60a396b030ad6aa3415f192aa5f7ee84cad5e11f7f5ae3"
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
