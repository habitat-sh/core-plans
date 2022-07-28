pkg_name=binutils
pkg_origin=core
pkg_version=2.37
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Binary Utilities, or binutils, are a set of programming tools for \
creating and managing binary programs, object files, libraries, profile data, \
and assembly source code.\
"
pkg_upstream_url="https://www.gnu.org/software/binutils/"
pkg_license=('GPL-2.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=67fc1a4030d08ee877a4867d3dcab35828148f87e1fd05da6db585ed5a166bd4
pkg_deps=(
  core/glibc
  core/zlib
  core/gcc-libs
)

pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/texinfo
  core/expect
  core/dejagnu
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  _verify_tty

  # Add explicit linker instructions as the binutils we are using may have its
  # own dynamic linker defaults.
  dynamic_linker="$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2"
  LDFLAGS="-L$(pkg_path_for zlib)/lib"
  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
  export LDFLAGS
  build_line "Updating LDFLAGS=$LDFLAGS"

  # Binutils has some vendored code that also exists in glibc but could be
  # API-incompatible, so we're going to zero-out the C*FLAGS environment
  # variables.
  CFLAGS="-I$(pkg_path_for zlib)/include"
  export CFLAGS
  build_line "Updating CFLAGS=$CFLAGS"
  CXXFLAGS="$CFLAGS"
  export CXXFLAGS
  build_line "Updating CXXFLAGS=$CXXFLAGS"
  CPPFLAGS="$CFLAGS"
  export CPPFLAGS
  build_line "Updating CPPFLAGS=$CPPFLAGS"

  # TODO: For the wrapper scripts to function correctly, we need the full
  # path to bash. Until a bash plan is created, we're going to wing this...
  bash=/bin/bash

  # Make `--enable-new-dtags` the default so that the linker sets `RUNPATH`
  # instead of `RPATH` in ELF binaries. This is important as `RPATH` is
  # overridden if `LD_LIBRARY_PATH` is set at runtime.

  # We don't want to search for libraries in system directories such as `/lib`,
  # `/usr/local/lib`, etc.
  echo 'NATIVE_LIB_DIRS=' >> ld/configure.tgt

  # Use symlinks instead of hard links to save space (otherwise `strip(1)`
  # needs to process each hard link seperately)
  for f in binutils/Makefile.in gas/Makefile.in ld/Makefile.in gold/Makefile.in; do
    sed -i "$f" -e 's|ln |ln -s |'
  done
}

do_build() {
#Applying patch for linking error with newer binutils.
#can be removed in the next version of 2.38
patch -p0 < "$PLAN_CONTEXT/malformarchive-linking-fix.patch"
  rm -rf ../${pkg_name}-build
  mkdir ../${pkg_name}-build
  pushd ../${pkg_name}-build > /dev/null
    "../$pkg_dirname/configure" \
      --prefix="$pkg_prefix" \
      --enable-shared \
      --enable-gold \
      --enable-ld=default \
      --enable-plugins \
      --enable-deterministic-archives \
      --enable-threads \
      --disable-werror \
      --with-system-zlib

    # Check the environment to make sure all the necessary tools are available
    make configure-host

    make -j"$(nproc)" tooldir="$pkg_prefix"
  popd > /dev/null
}

# skip stripping of binaries
do_strip() {
	return 0
}

do_check() {
  pushd ../${pkg_name}-build > /dev/null
    # This testsuite is pretty sensitive to its environment, especially when
    # libraries and headers are being flown in from non-standard locations.
    original_LD_RUN_PATH="$LD_RUN_PATH"
    if [[ "$STUDIO_TYPE" = "stage1" ]]; then
      LD_LIBRARY_PATH="$LD_RUN_PATH:/tools/lib"
    else
      LD_LIBRARY_PATH="$LD_RUN_PATH:$(pkg_path_for gcc)/lib"
    fi
    export LD_LIBRARY_PATH
    unset LD_RUN_PATH

    make check LDFLAGS="$LDFLAGS"

    unset LD_LIBRARY_PATH
    export LD_RUN_PATH="$original_LD_RUN_PATH"
  popd > /dev/null
}

do_install() {
  pushd ../"${pkg_name}-build" > /dev/null
    make prefix="$pkg_prefix" tooldir="$pkg_prefix" install

    # Remove unneeded files
    rm -fv "$pkg_prefix"/share/man/man1/{dlltool,nlmconv,windres,windmc}*

    # No shared linking to these files outside binutils
    rm -fv "$pkg_prefix"/lib/lib{bfd,opcodes}.so

    # Wrap key binaries so we can add some arguments and flags to the real
    # underlying binary.
    #
    # Thanks to: https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/cc-wrapper/ld-wrapper.sh
    # Thanks to: https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html
    _wrap_binary ld.bfd
  popd > /dev/null
}

_verify_tty() {
  # verify that PTYs are working properly
  local actual
  local expected='spawn ls'
  local cmd="expect -c 'spawn ls'"
  if actual=$(expect -c "spawn ls" | sed 's/\r$//'); then
    if [[ "$expected" != "$actual" ]]; then
      exit_with "Expected out from '$cmd' was: '$expected', actual: '$actual'" 1
    fi
  else
    exit_with "PTYs may not be working properly, aborting" 1
  fi
}

_wrap_binary() {
  local bin="$pkg_prefix/bin/$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  sed "$PLAN_CONTEXT/ld-wrapper.sh" \
    -e "s^@shell@^${bash}^g" \
    -e "s^@dynamic_linker@^${dynamic_linker}^g" \
    -e "s^@program@^${bin}.real^g" \
    > "$bin"
  chmod 755 "$bin"
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
