pkg_name=gawk
pkg_origin=core
pkg_version=4.2.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The awk utility interprets a special-purpose programming language that makes \
it possible to handle simple data-reformatting jobs with just a few lines of \
code.\
"
pkg_upstream_url="http://www.gnu.org/software/gawk/"
pkg_license=('gplv3+')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="c88046c6e8396ee548bcb941e16def809b7b55b60a1044b5dd254094f347c7d9"
pkg_deps=(
  core/glibc
  core/mpfr
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/awk bin/gawk)

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
  )
fi
