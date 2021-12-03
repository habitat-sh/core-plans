pkg_name=coreutils-static
_distname=coreutils
pkg_origin=core
pkg_version=9.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Core Utilities are the basic file, shell and text manipulation \
utilities of the GNU operating system. These are the core utilities which are \
expected to exist on every operating system.\
"
pkg_upstream_url="https://www.gnu.org/software/coreutils/"
pkg_license=('GPL-3.0')
pkg_source="http://ftp.gnu.org/gnu/$_distname/${_distname}-${pkg_version}.tar.xz"
pkg_shasum="ce30acdf4a41bc5bb30dd955e9eaa75fa216b4e3deb08889ed32433c7b3b97ce"
pkg_dirname=${_distname}-${pkg_version}

pkg_build_deps=(
  core/patch
  core/make
  core/gcc
  core/m4
  core/perl
  core/diffutils
  core/glibc
  core/acl
  core/attr
  core/gmp
  core/libcap
)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/env)

do_prepare() {
  _patch_files
}

do_build() {
  # Uses the `--enable-single-binary` flag to build a single binary file
  # (`coreutils`) which contains all tools in it.
  #
  # Thanks to: https://lists.gnu.org/archive/html/coreutils/2014-06/msg00036.html
  FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix="$pkg_prefix" \
    --enable-single-binary \
    LDFLAGS="-static $LDFLAGS"
  make
}

do_check() {
  make NON_ROOT_USERNAME=nobody check-root
  make RUN_EXPENSIVE_TESTS=yes check
}

_patch_files() {
  patch -p1 < "$PLAN_CONTEXT/skip-tests.patch"
}

# We will rely on tests from `coreutils`, so skip them here
unset -f do_check
