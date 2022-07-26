# Disable shellcheck that would require quotes around pkg_name
# shellcheck disable=SC2209
pkg_name=make
pkg_origin=core
pkg_version=4.3
pkg_description="\
Make is a tool which controls the generation of executables and other \
non-source files of a program from the program's source files.\
"
pkg_upstream_url="https://www.gnu.org/software/make/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="e05fdde47c5f7ca45cb697e973894ff4f5d79e13b750ed57d7b66d8defc78e19"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
  core/perl
  core/binutils
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)

do_check() {
  # Force `ar` to not run in deterministic mode, as the testsuite relies on
  # UID, GID, timestamp and file mode values to be correctly stored.
  #
  # Thanks to: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=782750
  mkdir -pv wrappers
  cat <<EOF > wrappers/ar
#!/bin/sh
exec $(pkg_path_for binutils)/bin/ar U\$@
EOF
  chmod -v 0744 wrappers/ar

  # The `PERL_USE_UNSAFE_INC=1` variable allows the test suite to run with Perl
  # 5.26 (resolves a "Can't locate driver" error).
  #
  # Thanks to:
  # * https://lists.gnu.org/archive/html/bug-make/2017-03/msg00040.html
  # * https://bugs.archlinux.org/task/55127
  env PATH="$(pwd)/wrappers:$PATH" PERL_USE_UNSAFE_INC=1 make check
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
    core/gcc
    core/sed
    core/bash
    core/perl
  )
fi
