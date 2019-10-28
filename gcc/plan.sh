pkg_name=gcc
_distname=$pkg_name
pkg_origin=core
pkg_version=8.2.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Compiler Collection (GCC) is a compiler system produced by the GNU \
Project supporting various programming languages. GCC is a key component of \
the GNU toolchain and the standard compiler for most Unix-like operating \
systems.\
"
pkg_upstream_url="https://gcc.gnu.org/"
pkg_license=('GPL-2.0')
pkg_source="http://ftp.gnu.org/gnu/$_distname/${_distname}-${pkg_version}/${_distname}-${pkg_version}.tar.xz"
pkg_shasum="196c3c04ba2613f893283977e6011b2345d1cd1af9abeac58e916b1aab3e0080"
pkg_deps=(
  core/glibc
  core/zlib
  core/gmp
  core/mpfr
  core/libmpc
  core/binutils
)
pkg_build_deps=(
  core/diffutils
  core/patch
  core/file
  core/make
  core/gcc
  core/gawk
  core/m4
  core/texinfo
  core/perl
  core/inetutils
  core/expect
  core/dejagnu
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  glibc="$(pkg_path_for glibc)"
  binutils="$(pkg_path_for binutils)"
  headers="$glibc/include"

  # Add explicit linker instructions as the binutils we are using may have its
  # own dynamic linker defaults.
  dynamic_linker="$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2"
  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
  build_line "Updating LDFLAGS=$LDFLAGS"

  # Remove glibc include directories from `$CFLAGS` as their contents will be
  # included in the `--with-native-system-header-dir` configure option
  orig_cflags="$CFLAGS"
  CFLAGS=
  for include in $orig_cflags; do
    if ! echo "$include" | grep -q "${glibc}" > /dev/null; then
      CFLAGS="$CFLAGS $include"
    fi
  done
  export CFLAGS
  build_line "Updating CFLAGS=$CFLAGS"

  # Set `CXXFLAGS` for the c++ code
  export CXXFLAGS="$CFLAGS"
  build_line "Setting CXXFLAGS=$CXXFLAGS"

  # Set `CPPFLAGS` which is set by the build system
  export CPPFLAGS="$CFLAGS"
  build_line "Setting CPPFLAGS=$CPPFLAGS"

  # Ensure gcc can find the headers for zlib
  CPATH="$(pkg_path_for zlib)/include"
  export CPATH
  build_line "Setting CPATH=$CPATH"

  # Ensure gcc can find the shared libs for zlib
  LIBRARY_PATH="$(pkg_path_for zlib)/lib"
  export LIBRARY_PATH
  build_line "Setting LIBRARY_PATH=$LIBRARY_PATH"

  # TODO: For the wrapper scripts to function correctly, we need the full
  # path to bash. Until a bash plan is created, we're going to wing this...
  bash=/bin/bash

  # Tell gcc not to look under the default `/lib/` and `/usr/lib/` directories
  # for libraries
  #
  # Thanks to: https://github.com/NixOS/nixpkgs/blob/release-15.09/pkgs/development/compilers/gcc/no-sys-dirs.patch
  patch -p1 < "$PLAN_CONTEXT/no-sys-dirs.patch"

  # Patch the configure script so it finds glibc headers
  #
  # Thanks to: https://github.com/NixOS/nixpkgs/blob/release-15.09/pkgs/development/compilers/gcc/builder.sh
  sed -i \
    -e "s,glibc_header_dir=/usr/include,glibc_header_dir=${headers}," \
    gcc/configure

  # Use the correct path to the dynamic linker instead of the default
  # `lib/ld*.so`
  #
  # Thanks to: https://github.com/NixOS/nixpkgs/blob/release-15.09/pkgs/development/compilers/gcc/5/default.nix
  build_line "Fixing the GLIBC_DYNAMIC_LINKER and UCLIBC_DYNAMIC_LINKER macros"
  for header in "gcc/config/"*-gnu.h "gcc/config/"*"/"*.h; do
    grep -q LIBC_DYNAMIC_LINKER "$header" || continue
    build_line "  Fixing $header"
    sed -i "$header" \
      -e 's|define[[:blank:]]*\([UCG]\+\)LIBC_DYNAMIC_LINKER\([0-9]*\)[[:blank:]]"\([^\"]\+\)"$|define \1LIBC_DYNAMIC_LINKER\2 "'"${glibc}"'\3"|g' \
      -e 's|/lib64/ld-linux-|/lib/ld-linux-|g'
  done

  # Installs x86_64 libraries under `lib/` vs the default `lib64/`
  #
  # Thanks to: https://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/gcc
  sed -i '/m64=/s/lib64/lib/' gcc/config/i386/t-linux64

  # Update all references to the `/usr/bin/file` absolute path with `file`
  # which will be on `$PATH` due to file being a build dependency.
  grep -lr /usr/bin/file ./* | while read -r f; do
    sed -i -e "s,/usr/bin/file,file,g" "$f"
  done

  # Build up the build cflags that will be set for multiple environment
  # variables in the `make` command
  build_cflags="-O2"
  build_cflags="$build_cflags -I${headers}"
  build_cflags="$build_cflags -B${glibc}/lib/"
  build_cflags="$build_cflags -idirafter"
  build_cflags="$build_cflags ${headers}"
  build_cflags="$build_cflags -idirafter"
  build_cflags="$build_cflags ${pkg_prefix}/lib/gcc/*/*/include-fixed"
  build_cflags="$build_cflags -Wl,-L${glibc}/lib"
  build_cflags="$build_cflags -Wl,-rpath"
  build_cflags="$build_cflags -Wl,${glibc}/lib"
  build_cflags="$build_cflags -Wl,-L${glibc}/lib"
  build_cflags="$build_cflags -Wl,-dynamic-linker"
  build_cflags="$build_cflags -Wl,${dynamic_linker}"

  # Build up the target ldflags that will be used in the `make` command
  target_ldflags="-Wl,-L${glibc}/lib"
  target_ldflags="$target_ldflags -Wl,-rpath"
  target_ldflags="$target_ldflags -Wl,${glibc}/lib"
  target_ldflags="$target_ldflags -Wl,-L${glibc}/lib"
  target_ldflags="$target_ldflags -Wl,-dynamic-linker"
  target_ldflags="$target_ldflags -Wl,${dynamic_linker}"
  target_ldflags="$target_ldflags -Wl,-L${glibc}/lib"
  target_ldflags="$target_ldflags -Wl,-rpath"
  target_ldflags="$target_ldflags -Wl,${glibc}/lib"
  target_ldflags="$target_ldflags -Wl,-L${glibc}/lib"
  target_ldflags="$target_ldflags -Wl,-dynamic-linker"
  target_ldflags="$target_ldflags -Wl,${dynamic_linker}"
}

do_build() {
  rm -rf "../${pkg_name}-build"
  mkdir "../${pkg_name}-build"
  pushd "../${pkg_name}-build" > /dev/null
    SED=sed \
    LD="$(pkg_path_for binutils)/bin/ld" \
    AS="$(pkg_path_for binutils)/bin/as" \
    "../$pkg_dirname/configure" \
      --prefix="$pkg_prefix" \
      --with-gmp="$(pkg_path_for gmp)" \
      --with-mpfr="$(pkg_path_for mpfr)" \
      --with-mpc="$(pkg_path_for libmpc)" \
      --with-native-system-header-dir="$headers" \
      --enable-languages=c,c++,fortran \
      --enable-lto \
      --enable-plugin \
      --enable-shared \
      --enable-threads=posix \
      --enable-install-libiberty \
      --enable-vtable-verify \
      --disable-werror \
      --disable-multilib \
      --with-system-zlib \
      --disable-libstdcxx-pch

    # Don't store the configure flags in the resulting executables.
    #
    # Thanks to: https://github.com/NixOS/nixpkgs/blob/release-15.09/pkgs/development/compilers/gcc/builder.sh
    sed -e '/TOPLEVEL_CONFIGURE_ARGUMENTS=/d' -i Makefile

    # CFLAGS_FOR_TARGET are needed for the libstdc++ configure script to find
    # the startfiles.
    # FLAGS_FOR_TARGET are needed for the target libraries to receive the -Bxxx
    # for the startfiles.
    #
    # Thanks to: https://github.com/NixOS/nixpkgs/blob/release-15.09/pkgs/development/compilers/gcc/builder.sh
    make \
      -j"$(nproc)" \
      NATIVE_SYSTEM_HEADER_DIR="$headers" \
      SYSTEM_HEADER_DIR="$headers" \
      CFLAGS_FOR_BUILD="$build_cflags" \
      CXXFLAGS_FOR_BUILD="$build_cflags" \
      CFLAGS_FOR_TARGET="$build_cflags" \
      CXXFLAGS_FOR_TARGET="$build_cflags" \
      FLAGS_FOR_TARGET="$build_cflags" \
      LDFLAGS_FOR_BUILD="$build_cflags" \
      LDFLAGS_FOR_TARGET="$target_ldflags" \
      BOOT_CFLAGS="$build_cflags" \
      BOOT_LDFLAGS="$build_cflags" \
      LIMITS_H_TEST=true \
      profiledbootstrap
  popd > /dev/null
}

do_check() {
  pushd "../${pkg_name}-build" > /dev/null
    # One set of tests in the GCC test suite is known to exhaust the stack,
    # so increase the stack size prior to running the tests
    ulimit -s 32768

    unset CPATH LIBRARY_PATH
    export LIBRARY_PATH="$LD_RUN_PATH"
    # Do not abort on error as some are "expected"
    # Currently, the tests will report the following unexpected errors:
    #
    # gcc:
    #
    #  FAIL: c-c++-common/tsan/thread_leak1.c   -O0  output pattern test
    #  FAIL: c-c++-common/tsan/thread_leak1.c   -O2  output pattern test
    #
    # g++:
    #
    #  FAIL: c-c++-common/tsan/thread_leak1.c   -O0  output pattern test
    #  FAIL: c-c++-common/tsan/thread_leak1.c   -O2  output pattern test
    #
    # libstdc++:
    #
    #  FAIL: libstdc++-abi/abi_check
    #  FAIL: 22_locale/codecvt/encoding/wchar_t/2.cc execution test
    #  FAIL: 22_locale/codecvt/encoding/wchar_t/3.cc execution test
    #  FAIL: 22_locale/codecvt/in/wchar_t/2.cc execution test
    #  FAIL: 22_locale/codecvt/length/wchar_t/2.cc execution test
    #  FAIL: 22_locale/codecvt/length/wchar_t/3.cc execution test
    #  FAIL: 22_locale/codecvt/max_length/wchar_t/2.cc execution test
    #  FAIL: 22_locale/codecvt/max_length/wchar_t/3.cc execution test
    #  FAIL: 22_locale/codecvt/out/wchar_t/2.cc execution test
    #  FAIL: 22_locale/codecvt/out/wchar_t/7.cc execution test
    #  FAIL: 22_locale/ctype/widen/wchar_t/2.cc execution test
    #  FAIL: experimental/filesystem/iterators/directory_iterator.cc execution test
    #  FAIL: experimental/filesystem/iterators/recursive_directory_iterator.cc execution test
    #  FAIL: experimental/filesystem/operations/exists.cc execution test
    #  FAIL: experimental/filesystem/operations/is_empty.cc execution test
    #  FAIL: experimental/filesystem/operations/remove.cc execution test
    #  FAIL: experimental/filesystem/operations/temp_directory_path.cc execution test

    make -k check || true
    unset LIBRARY_PATH

    build_line "Displaying Test Summary"
    "../$pkg_dirname/contrib/test_summary"
  popd > /dev/null
}

do_install() {
  pushd "../${pkg_name}-build" > /dev/null
    # Make 'lib64' a symlink to 'lib'
    mkdir -pv "$pkg_prefix/lib"
    ln -sv lib "$pkg_prefix/lib64"

    make install

    # Install PIC version of libiberty which lets Binutils successfully build.
    # As of some point in the near past (2015+ ?), the GCC distribution
    # maintains the libiberty code and not Binutils (they each used to
    # potentially install `libiberty.a` which was confusing as to the "owner").
    #
    # Thanks to: https://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/gcc
    install -v -m644 libiberty/pic/libiberty.a "$pkg_prefix/lib"

    # Install Runtime Library Exception
    install -Dm644 "../$pkg_dirname/COPYING.RUNTIME" \
      "$pkg_prefix/share/licenses/RUNTIME.LIBRARY.EXCEPTION"

    # Replace hard links for x86_64-unknown-linux-gnu etc. with symlinks
    #
    # Thanks to: https://github.com/NixOS/nixpkgs/blob/release-15.09/pkgs/development/compilers/gcc/builder.sh
    for bin in "$pkg_prefix/bin/"*-gcc*; do
      if cmp -s "$pkg_prefix/bin/gcc" "$bin"; then
        ln -sfnv gcc "$bin"
      fi
    done

    # Replace hard links for x86_64-unknown-linux-g++ etc. with symlinks
    for bin in "$pkg_prefix/bin/c++" "$pkg_prefix/bin/"*-c++* "$pkg_prefix/bin/"*-g++*; do
      if cmp -s "$pkg_prefix/bin/g++" "$bin"; then
        ln -sfn g++ "$bin"
      fi
    done

    # Many packages use the name cc to call the C compiler
    ln -sv gcc "$pkg_prefix/bin/cc"

    # Wrap key binaries so we can add some arguments and flags to the real
    # underlying binary. This should make Plan author's lives a bit easier
    # as they won't have to worry about setting the correct dynamic linker
    # (from glibc) and finding the correct path to the special linker object
    # files such as `crt1.o` and gang.
    #
    # Thanks to: https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/cc-wrapper/cc-wrapper.sh
    # Thanks to: https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html
    wrap_binary gcc
    wrap_binary g++
    wrap_binary cpp
  popd > /dev/null
}

wrap_binary() {
  local bin="$pkg_prefix/bin/$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  sed "$PLAN_CONTEXT/cc-wrapper.sh" \
    -e "s^@shell@^${bash}^g" \
    -e "s^@glibc@^${glibc}^g" \
    -e "s^@binutils@^${binutils}^g" \
    -e "s^@gcc@^${pkg_prefix}^g" \
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
  pkg_build_deps=(
    core/m4
    core/file
  )
fi
