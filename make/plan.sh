pkg_name=make
pkg_origin=core
pkg_version=4.2.1
pkg_description="Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://www.gnu.org/software/make/
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=d6e262bf3601b42d2b1e4ef8310029e1dcf20083c5446b4b7aa67081fdffc589
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/bash core/gettext core/gzip core/perl core/binutils)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)

do_prepare() {
  do_default_prepare

  # Don't look for library dependencies in the root system (i.e. `/lib`,
  # `/usr/lib`, etc.)
  patch -p1 -i "$PLAN_CONTEXT/no-sys-dirs.patch"
}

do_check() {
  # Force `ar` to not run in deterministic mode, as the testsuite relies on
  # UID, GID, timestamp and file mode values to be correctly stored.
  #
  # Thanks to: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=782750
  mkdir -pv wrappers
  cat <<EOF > wrappers/ar
#!$(pkg_path_for bash)/bin/sh
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
  pkg_build_deps=(core/binutils core/gcc core/coreutils core/sed core/bash core/perl core/diffutils core/gettext core/gzip)
fi
