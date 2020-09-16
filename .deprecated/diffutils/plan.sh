pkg_name=diffutils
pkg_origin=core
pkg_version=3.7
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU Diffutils is a package of several programs related to finding differences \
between files.\
"
pkg_upstream_url="https://www.gnu.org/software/diffutils"
pkg_license=('GPL-3.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="b3a7a6221c3dc916085f0d205abf6b8e1ba443d4dd965118da364a1dc1cb3a26"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/make
  core/gcc
  core/sed
)
pkg_bin_dirs=(bin)

do_build() {
  # Since glibc >= 2.26, don't try to use getopt_long replacement bundled with
  # diffutils. It will conflict with the one from glibc.
  #
  # Thanks to: https://patchwork.ozlabs.org/patch/809145/
  echo "gl_cv_func_getopt_gnu=yes" >> config.cache

  ./configure \
    --prefix="$pkg_prefix" \
    --cache-file=config.cache
  make
}

do_check() {
  # Fixes a broken test with either gcc 5.2.x and/or perl 5.22.x:
  # FAIL: test-update-copyright.sh
  #
  # Thanks to: http://permalink.gmane.org/gmane.linux.lfs.devel/16285
  sed -i 's/copyright{/copyright\\{/' build-aux/update-copyright

  # Add ./src to PATH so that the test suite can use the just-build `cmp`
  # program. Seems pretty meta to me...
  make check PATH="$(pwd)/src:$PATH"
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
