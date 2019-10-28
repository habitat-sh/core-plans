pkg_name=libmpc
_distname=mpc
pkg_origin=core
pkg_version=1.1.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU MPC is a C library for the arithmetic of complex numbers with arbitrarily \
high precision and correct rounding of the result.\
"
pkg_upstream_url="http://www.multiprecision.org/"
pkg_license=('lgpl')
pkg_source="https://ftp.gnu.org/gnu/${_distname}/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="6985c538143c1208dcb1ac42cedad6ff52e267b47e5f970183a3e75125b43c2e"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
  core/gmp
  core/mpfr
)
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
  core/binutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  do_default_prepare

  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  build_line "Updating LDFLAGS=$LDFLAGS"
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
  pkg_build_deps=(
    core/binutils
  )
fi
