pkg_name=gettext
pkg_origin=core
pkg_version=0.21
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GNU internationalization library."
pkg_upstream_url="http://www.gnu.org/software/gettext/"
pkg_license=('GPL-2.0-or-later' 'LGPL-2.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="c77d0da3102aec9c07f43671e60611ebff89a996ef159497ce8e59d075786b12"
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/acl
  core/xz
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
  core/findutils
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_prepare() {
  do_default_prepare

  patch -p1 -i "$PLAN_CONTEXT/disable-test.patch"
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix"
  make -j"$(nproc)"
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
    core/gcc
    core/coreutils
    core/sed
    core/diffutils
    core/findutils
  )
fi
