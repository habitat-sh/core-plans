pkg_name=autoconf
pkg_origin=core
pkg_version=2.71
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Autoconf is an extensible package of M4 macros that produce shell scripts to \
automatically configure software source code packages.\
"
pkg_upstream_url="https://www.gnu.org/software/autoconf/autoconf.html"
pkg_license=('GPL-2.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="f14c83cfebcc9427f2c3cea7258bd90df972d92eb26752da4ddad81c87a0faa4"
pkg_deps=(
  core/m4
  core/perl
)
pkg_build_deps=(
  core/diffutils
  core/inetutils
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)


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
    core/gawk
    core/diffutils
  )
fi
