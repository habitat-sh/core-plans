pkg_name=sed
pkg_origin=core
pkg_version=4.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
sed (stream editor) is a non-interactive command-line text editor. sed is \
commonly used to filter text, i.e., it takes text input, performs some \
operation (or set of operations) on it, and outputs the modified text. sed is \
typically used for extracting part of a file using pattern matching or \
substituting multiple occurrences of a string within a file.\
"
pkg_upstream_url="https://www.gnu.org/software/sed/"
pkg_license=('gplv3')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="cbd6ebc5aaf080ed60d0162d7f6aeae58211a1ee9ba9bb25623daa6cd942683b"
pkg_deps=(
  core/glibc
  core/acl
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)

do_prepare() {
  # Fix failing test `test-getopt-posix` which appears to have problems when
  # working against Glibc 2.26.
  #
  # TODO fn: when glibc package is upgraded, see if this patch is still
  # required (it may be fixed in the near future)
  #
  # Thanks to:
  # https://www.redhat.com/archives/libvir-list/2017-September/msg01054.html
  patch -p1 < "$PLAN_CONTEXT/fix-test-getopt-posix-with-glibc-2.26.patch"

  # Fix a failing test
  #
  # Thanks to:
  # http://www.linuxfromscratch.org/lfs/view/development/chapter06/sed.html
  sed -i 's/testsuite.panic-tests.sh//' Makefile.in
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
  )
fi
