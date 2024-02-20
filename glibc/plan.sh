pkg_name=glibc
pkg_origin=core
pkg_version="2.35"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU C Library project provides the core libraries for the GNU system and \
GNU/Linux systems, as well as many other systems that use Linux as the \
kernel. These libraries provide critical APIs including ISO C11, \
POSIX.1-2008, BSD, OS-specific APIs and more. These APIs include such \
foundational facilities as open, read, write, malloc, printf, getaddrinfo, \
dlopen, pthread_create, crypt, login, exit and more.\
"
pkg_upstream_url="https://www.gnu.org/software/libc"
pkg_license=('GPL-2.0-or-later' 'LGPL-2.1-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="5123732f6b67ccd319305efd399971d58592122bcc2a6518a1bd2510dd0cf52e"
pkg_deps=(
  core/linux-headers
)
pkg_build_deps=(
  core/coreutils
  core/bison
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
  core/perl
  core/m4
  core/python-minimal
  core/tzdata
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  # The `/bin/pwd` path is hardcoded, so we'll add a symlink if needed.
  if [[ ! -r /bin/pwd ]]; then
    # We can't use the `command -v pwd` trick here, as `pwd` is a shell
    # builtin, and therefore returns the string of "pwd" (i.e. not the full
    # path to the executable on `$PATH`). In a stage1 Studio, the coreutils
    # package isn't built yet so we can't rely on using the `pkg_path_for`
    # helper either.  Sweet twist, no?
    if [[ "$STUDIO_TYPE" = "stage1" ]]; then
      ln -sv /tools/bin/pwd /bin/pwd
    else
      ln -sv "$(pkg_path_for coreutils)/bin/pwd" /bin/pwd
    fi
    _clean_pwd=true
  fi

  # Determine the full path to the linker which will be produced.
  dynamic_linker="$pkg_prefix/lib/ld-linux-x86-64.so.2"

  # We don't want glibc to try and reference itself before it's installed,
  # no `$LD_RUN_PATH`s here
  unset LD_RUN_PATH
  build_line "Overriding LD_RUN_PATH=$LD_RUN_PATH"

  unset CFLAGS
  build_line "Overriding CFLAGS=$CFLAGS"

  # Add a dynamic-linker option to `$LDFLAGS` so that every dynamic ELF binary
  # will use our own dynamic linker and not a previously built version.
  LDFLAGS="-Wl,--dynamic-linker=$dynamic_linker"
  build_line "Setting LDFLAGS=$LDFLAGS"

  # Don't depend on dynamically linked libgcc for nscd, as we don't want it
  # depending on any bootstrapped version.
  echo "LDFLAGS-nscd += -static-libgcc" >> nscd/Makefile

	# This is patch to fix compile error with linker diagnostics featue in v2.34
	# It can be removed in future upgrades as feature matures.
	sed -i 's/SYSCONFDIR/PREFIX "\/etc"/' elf/dl-diagnostics.c

  # Don't use the system's `/etc/ld.so.cache` and `/etc/ld.so.preload`, but
  # rather the version under `$pkg_prefix/etc`.
  #
  # Thanks to https://github.com/NixOS/nixpkgs/blob/54fc2db/pkgs/development/libraries/glibc/dont-use-system-ld-so-cache.patch
  # and to https://github.com/NixOS/nixpkgs/blob/dac591a/pkgs/development/libraries/glibc/dont-use-system-ld-so-preload.patch
  # shellcheck disable=SC2002
  cat "$PLAN_CONTEXT/dont-use-system-ld-so.patch" \
    | sed "s,@prefix@,$pkg_prefix,g" \
    | patch -p1

  # Adjust `scripts/test-installation.pl` to use our new dynamic linker
  sed -i "s|libs -o|libs -L${pkg_prefix}/lib -Wl,-dynamic-linker=${dynamic_linker} -o|" \
    scripts/test-installation.pl
}

do_build() {
  rm -rf ../${pkg_name}-build
  mkdir ../${pkg_name}-build
  pushd ../${pkg_name}-build > /dev/null
    # Configure Glibc to install its libraries into `$pkg_prefix/lib`
    echo "libc_cv_slibdir=$pkg_prefix/lib" >> config.cache

    "../$pkg_dirname/configure" \
      --prefix="$pkg_prefix" \
      --sbindir="$pkg_prefix/bin" \
      --with-headers="$(pkg_path_for linux-headers)/include" \
      --libdir="$pkg_prefix/lib" \
      --libexecdir="$pkg_prefix/lib/glibc" \
      --sysconfdir="$pkg_prefix/etc" \
      --enable-obsolete-rpc \
      --disable-profile \
      --enable-kernel=3.2 \
      --enable-stack-protector=strong \
      --enable-cet \
      --cache-file=config.cache

    make
  popd > /dev/null
}

# Running a `make check` is considered one critical test of the correctness of
# the resulting glibc build. Unfortunetly, the time to complete the test suite
# rougly triples the build time of this Plan and there are at least 2 known
# failures which means that `make check` certainly returns a non-zero exit
# code. Despite these downsides, it is still worth the pain when building the
# first time in a new environment, or when a new upstream version is attempted.
#
# There are known failures in `make check`, but most likely known ones, given a
# build on a full virtual machine or physical server. Here are the known
# failures and why:
#
# ## FAIL: elf/check-abi-libc
#
# "You might see a check failure due to a different size for
# `_nl_default_dirname` if you build for a different prefix using the
# `--prefix` configure option. The size of `_nl_default_dirname` depends on the
# prefix and `/usr/share/locale` is considered the default and hence the value
# 0x12. If you see such a difference, you should check that the size
# corresponds to your prefix, i.e. `(length of prefix path + 1)` to ensure that
# you haven't really broken abi with your change."
#
# Source:
# https://sourceware.org/glibc/wiki/Testing/Testsuite#Known_testsuite_failures
#
# ## FAIL: posix/tst-getaddrinfo4
#
# "This test will always fail due to not having the necessary networking
# applications when the tests are run."
#
# Source: http://www.linuxfromscratch.org/lfs/view/stable/chapter06/glibc.html
#
do_check() {
  pushd ../${pkg_name}-build > /dev/null
    # One of the tests uses the hardcoded `bin/cat` path, so we'll add it, if
    # it doesn't exist.
    # Checking for the binary on `$PATH` will work in both stage1 and default
    # Studios.
    if [[ ! -r /bin/cat ]]; then
      ln -sv "$(command -v cat)" /bin/cat
      _clean_cat=true
    fi
    # One of the tests uses the hardcoded `bin/echo` path, so we'll add it, if
    # it doesn't exist.
    if [[ ! -r /bin/echo ]]; then
      # We can't use the `command -v echo` trick here, as `echo` is a shell
      # builtin, and therefore returns the string of "echo" (i.e. not the full
      # path to the executable on `$PATH`). In a stage1 Studio, the coreutils
      # package isn't built yet so we can't rely on using the `pkg_path_for`
      # helper either. Sweet twist, no?
      if [[ "$STUDIO_TYPE" = "stage1" ]]; then
        ln -sv /tools/bin/echo /bin/echo
      else
        ln -sv "$(pkg_path_for coreutils)/bin/echo" /bin/echo
      fi
      _clean_echo=true
    fi

    # "If the test system does not have suitable copies of libgcc_s.so and
    # libstdc++.so installed in system library directories, it is necessary to
    # copy or symlink them into the build directory before testing (see
    # https://sourceware.org/ml/libc-alpha/2012-04/msg01014.html regarding the
    # use of system library directories here)."
    #
    # Source: https://sourceware.org/glibc/wiki/Release/2.23
    # Source: http://www0.cs.ucl.ac.uk/staff/ucacbbl/glibc/index.html#bug-atexit3
    if [[ "$STUDIO_TYPE" = "stage1" ]]; then
      ln -sv /tools/lib/libgcc_s.so.1 .
      ln -sv /tools/lib/libstdc++.so.6 .
    else
      ln -sv "$(pkg_path_for gcc)/lib/libgcc_s.so.1" .
      ln -sv "$(pkg_path_for gcc)/lib/libstdc++.so.6" .
    fi

    # It appears as though some tests *always* fail, but since the output (and
    # passing tests) is of value, we will run the anyway. Expect ignore the
    # exit code. I am sad.
    make check || true

    rm -fv ./libgcc_s.so.1 ./libstdc++.so.6

    # Clean up the symlinks if we set it up.
    if [[ -n "$_clean_echo" ]]; then
      rm -fv /bin/echo
    fi
    if [[ -n "$_clean_cat" ]]; then
      rm -fv /bin/cat
    fi
  popd > /dev/null
}

do_install() {
  pushd ../${pkg_name}-build > /dev/null
    # Prevent a `make install` warning of a missing `ld.so.conf`.
    mkdir -p "$pkg_prefix/etc"
    touch "$pkg_prefix/etc/ld.so.conf"

    # To ensure the `make install` checks at the end succeed. Unfortunately,
    # a multilib installation is assumed (i.e. 32-bit and 64-bit). We will
    # fool this check by symlinking a "32-bit" file to the real loader.
    mkdir -p "$pkg_prefix/lib"
    ln -sv ld-${pkg_version}.so "$pkg_prefix/lib/ld-linux.so.2"

    # Add a `lib64` -> `lib` symlink for `bin/ldd` to work correctly.
    #
    # Thanks to: https://github.com/NixOS/nixpkgs/blob/55b03266cfc25ae019af3cdd2cfcad0facdc68f2/pkgs/development/libraries/glibc/builder.sh#L43-L47
    ln -sv lib "$pkg_prefix/lib64"

    if [[ "$STUDIO_TYPE" = "stage1" ]]; then
      # When building glibc using a build toolchain, we need libgcc_s at
      # `$RPATH` which gets us by until we can link against this for real
      if [ -f /tools/lib/libgcc_s.so.1 ]; then
        cp -v /tools/lib/libgcc_s.so.1 "$pkg_prefix/lib/"
        # the .so file used to be a symlink, but now it is a script
        cp -av /tools/lib/libgcc_s.so "$pkg_prefix/lib/"
      fi
    fi

    make install sysconfdir="$pkg_prefix/etc" sbindir="$pkg_prefix/bin"

    # Move all remaining binaries in `sbin/` into `bin/`, namely `ldconfig`
    mv "$pkg_prefix/sbin"/* "$pkg_prefix/bin/"
    rm -rf "$pkg_prefix/sbin"

    # Remove unneeded files from `include/rpcsvc`
    rm -fv "$pkg_prefix/include/rpcsvc"/*.x

    # Remove the `make install` check symlink
    rm -fv "$pkg_prefix/lib/ld-linux.so.2"

    # Remove `sln` (statically built ln)--not needed
    rm -f "$pkg_prefix/bin/sln"

    # Update the shebangs of a few shell scripts that have a fully-qualified
    # path to `/bin/sh` so they will work in a minimal busybox
    for b in ldd sotruss tzselect xtrace; do
      sed -e 's,^#!.*$,#! /bin/sh,' -i "$pkg_prefix/bin/$b"
    done

    # Include the Linux kernel headers in Glibc, except the `scsi/` directory,
    # which Glibc provides itself.
    #
    # We can thank GCC for this requirement; we must provide a single path
    # value for the `--with-native-system-header-dir` configure option and this
    # path must contain libc and kernel headers (the assumption is we are
    # running a common operating system with everything under `/usr/include`).
    # GCC then bakes this path in when it builds itself, thus it's pretty
    # important for any future GCC-built packages. If there is an alternate way
    # we can make GCC happy, then we'll change this up. This is the best of a
    # sad, sad situation.
    #
    # Thanks to: https://github.com/NixOS/nixpkgs/blob/55b03266cfc25ae019af3cdd2cfcad0facdc68f2/pkgs/development/libraries/glibc/builder.sh#L25-L32
    pushd "$pkg_prefix/include" > /dev/null
      # shellcheck disable=SC2010,SC2046
      ln -sv $(ls -d $(pkg_path_for linux-headers)/include/* | grep -v 'scsi$') .
    popd > /dev/null

    mkdir -pv "$pkg_prefix/lib/locale"
    localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
    localedef -i de_DE -f ISO-8859-1 de_DE
    localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
    localedef -i en_HK -f ISO-8859-1 en_HK
    localedef -i en_PH -f ISO-8859-1 en_PH
    localedef -i en_US -f ISO-8859-1 en_US
    localedef -i en_US -f UTF-8 en_US
    localedef -i es_MX -f ISO-8859-1 es_MX
    localedef -i fa_IR -f UTF-8 fa_IR
    localedef -i fr_FR -f ISO-8859-1 fr_FR
    localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
    localedef -i it_IT -f ISO-8859-1 it_IT
    localedef -i ja_JP -f EUC-JP ja_JP

    cp -v "../$pkg_dirname/nscd/nscd.conf" "$pkg_prefix/etc/"

    cat > "$pkg_prefix/etc/nsswitch.conf" << "EOF"
passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files
EOF


    # Install timezone data.
    # We set --sysconfdir=$pkg_prefix/etc during our build, so we need to
    # embed timezone data in this package.
    # Please see core/tzdata for more information.

    cp -r "$(pkg_path_for tzdata)/share/zoneinfo" "$pkg_prefix/share/"
    cp -v "$(pkg_path_for tzdata)/share/zoneinfo/UTC" "$pkg_prefix/etc/localtime"
}

do_strip() {
  build_line "Stripping unneeded symbols from binaries and libraries"
  find "$pkg_prefix" -type f -perm -u+w -print0 2> /dev/null \
    | while read -rd '' f; do
      case "$(basename "$f")" in
        "ld-${pkg_version}.so"|\
        "libc-${pkg_version}.so"|\
        "libpthread-${pkg_version}.so"|\
        libpthread_db-1.0.so)
          build_line "Skipping strip for $f"
          continue
          ;;
      esac

      case "$(file -bi "$f")" in
        *application/x-executable*) strip --strip-all "$f";;
        *application/x-pie-executable*) strip --strip-all "$f";;
        *application/x-sharedlib*) strip --strip-unneeded "$f";;
        *application/x-archive*) strip --strip-debug "$f";;
        *) continue;;
      esac
    done
}

do_end() {
  # Clean up the `pwd` link, if we set it up.
  if [[ -n "$_clean_pwd" ]]; then
    rm -fv /bin/pwd
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
  pkg_build_deps=()
fi
