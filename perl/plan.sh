pkg_name=perl
pkg_origin=core
pkg_version=5.34.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Perl 5 is a highly capable, feature-rich programming language with over 29 \
years of development.\
"
pkg_upstream_url="http://www.perl.org/"
pkg_license=('GPL-1.0-or-later' 'Artistic-1.0-Perl')
pkg_source="http://www.cpan.org/src/5.0/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="551efc818b968b05216024fb0b727ef2ad4c100f8cb6b43fab615fa78ae5be9a"
pkg_deps=(
  core/glibc
  core/zlib
  core/bzip2
  core/gdbm
  core/db
  core/coreutils
  core/less
)
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
  core/procps-ng
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_interpreters=(bin/perl)

do_prepare() {
  do_default_prepare

  #  Make Cwd work with the `pwd` command from `coreutils` (we cannot rely
  #  on `/bin/pwd` exisiting in an environment)
  sed -i "s,'/bin/pwd','$(pkg_path_for coreutils)/bin/pwd',g" \
    dist/PathTools/Cwd.pm

  # Build the `-Dlocincpth` configure flag, which is collection of all
  # directories containing headers. As the `$CFLAGS` environment variable has
  # this list, we will raid it, looking for tokens starting with `-I/`.
  locincpth=""
  for i in $CFLAGS; do
    if echo "$i" | grep -q "^-I\/" > /dev/null; then
      # shellcheck disable=SC2001
      locincpth="$locincpth $(echo "$i" | sed 's,^-I,,')"
    fi
  done

  # Build the `-Dloclibpth` configure flag, which is collection of all
  # directories containing shared libraries. As the `$LDFLAGS` environment
  # variable has this list, we will raid it, looking for tokens starting with
  # `-L/`.
  loclibpth=""
  for i in $LDFLAGS; do
    if echo "$i" | grep -q "^-L\/" > /dev/null; then
      # shellcheck disable=SC2001
      loclibpth="$loclibpth $(echo "$i" | sed 's,^-L,,')"
    fi
  done

  # When building a shared `libperl`, the `$LD_LIBRARY_PATH` environment
  # variable is used for shared library lookup. This maps pretty exactly to the
  # collections of paths already in `$LD_RUN_PATH` with the exception of the
  # build directory, which will contain the build shared Perl library.
  #
  # Thanks to: http://perl5.git.perl.org/perl.git/blob/c52cb8175c7c08890821789b4c7177b1e0e92558:/INSTALL#l478
  LD_LIBRARY_PATH="$(pwd):$LD_RUN_PATH"
  export LD_LIBRARY_PATH
  build_line "Setting LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
}

do_build() {
  # Use the already-built shared libraries for zlib and bzip2 modules
  export BUILD_ZLIB=False
  export BUILD_BZIP2=0

  sh Configure \
    -de \
    -Dprefix="$pkg_prefix" \
    -Dman1dir="$pkg_prefix/share/man/man1" \
    -Dman3dir="$pkg_prefix/share/man/man3" \
    -Dlocincpth="$locincpth" \
    -Dloclibpth="$loclibpth" \
    -Dpager="$(pkg_path_for less)/bin/less -isR" \
    -Dinstallstyle=lib/perl5 \
    -Uinstallusrbinperl \
    -Duseshrplib \
    -Dusethreads \
    -Dinc_version_list=none \
    -Dlddlflags="-shared ${LDFLAGS}" \
    -Dldflags="${LDFLAGS}"
  make -j"$(nproc)"

  # Clear temporary build time environment variables
  unset BUILD_ZLIB BUILD_BZIP2
}

do_check() {
  # If `/etc/services` and/or `/etc/protocols` does not exist, make temporary
  # versions from the `iana-etc` package. This is needed for several
  # network-related tests to pass.
  if [[ ! -f /etc/services ]]; then
    cp -v "$(pkg_path_for iana-etc)/etc/services" /etc/services
    local clean_services=true
  fi
  if [[ ! -f /etc/protocols ]]; then
    cp -v "$(pkg_path_for iana-etc)/etc/protocols" /etc/protocols
    local clean_protocols=true
  fi

  make test

  # If the `/etc/services` or `/etc/protocols` files were added for the
  # purposes of this test suite, clean them up. Otherwise leave them be.
  if [[ -n "$clean_services" ]]; then
    rm -fv /etc/services
  fi
  if [[ -n "$clean_protocols" ]]; then
    rm -fv /etc/protocols
  fi
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
    core/procps-ng
    core/inetutils
    core/iana-etc
  )
fi
