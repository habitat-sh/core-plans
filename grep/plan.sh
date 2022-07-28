# This comment line avoids shellcheck disabling checks for the entire file
# shellcheck disable=SC2209
pkg_name=grep
pkg_origin=core
pkg_version=3.7
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Grep searches one or more input files for lines containing a match to a \
specified pattern. By default, Grep outputs the matching lines.\
"
pkg_upstream_url="https://www.gnu.org/software/grep/"
pkg_license=('GPL-3.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="5c10da312460aec721984d5d83246d24520ec438dd48d7ab5a05dbc0d6d6823c"
pkg_deps=(
  core/glibc
  core/pcre
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/perl
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
  )
fi
