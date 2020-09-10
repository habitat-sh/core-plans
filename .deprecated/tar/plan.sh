pkg_name=tar
pkg_origin=core
pkg_version=1.32
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU Tar provides the ability to create tar archives, as well as various other \
kinds of manipulation.\
"
pkg_upstream_url="https://www.gnu.org/software/tar/"
pkg_license=('GPL-3.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="b59549594d91d84ee00c99cf2541a3330fed3a42c440503326dab767f2fbb96c"
pkg_deps=(
  core/glibc
  core/acl
  core/attr
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

do_build() {
  # * `FORCE_UNSAFE_CONFIGURE` forces the test for `mknod` to be run as root
  FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix="$pkg_prefix"
  make
}

do_check() {
  # Test listed04.at will fail on some machines (OSX laptops are known to have this issue)
  # Ref: https://github.com/habitat-sh/core-plans/issues/1636
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
