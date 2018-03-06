pkg_name=coreutils
_distname=$pkg_name
pkg_origin=core
pkg_version=8.29
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Core Utilities are the basic file, shell and text manipulation \
utilities of the GNU operating system. These are the core utilities which are \
expected to exist on every operating system.\
"
pkg_upstream_url="https://www.gnu.org/software/coreutils/"
pkg_license=('GPL-3.0')
pkg_source="http://ftp.gnu.org/gnu/$_distname/${_distname}-${pkg_version}.tar.xz"
pkg_shasum="92d0fa1c311cacefa89853bdb53c62f4110cdfda3820346b59cbd098f40f955e"
pkg_deps=(
  core/glibc
  core/acl
  core/attr
  core/gmp
  core/libcap
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/m4
  core/perl
  core/inetutils
)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/env)

do_prepare() {
  _patch_files
}

do_build() {
  # The `FORCE_` variable allows the software to compile with the root user,
  # and the `--enable-no-install-program` flag skips installation of binaries
  # that are provided by other pacakges.
  FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix="$pkg_prefix" \
    --enable-no-install-program=kill,uptime
  make
}

do_check() {
  make NON_ROOT_USERNAME=nobody check-root
  make RUN_EXPENSIVE_TESTS=yes check
}

_patch_files() {
  patch -p1 < "$PLAN_CONTEXT/skip-tests.patch"
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
    core/m4
  )
fi
