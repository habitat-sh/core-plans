pkg_name=bzip2
_distname=$pkg_name
pkg_origin=core
pkg_version=1.0.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
bzip2 is a free and open-source file compression program that uses the \
Burrows–Wheeler algorithm. It only compresses single files and is not a file \
archiver.\
"
pkg_upstream_url="http://www.bzip.org/"
pkg_license=('bzip2')
pkg_source="https://fossies.org/linux/misc/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

_common_prepare() {
  # Makes the symbolic links in installation relative vs. absolute
  # shellcheck disable=SC2016
  sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

  # Ensure that the man pages are installed under share/man
  sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
}

do_prepare() {
  _common_prepare

  export CC=gcc
  build_line "Setting CC=$CC"
}

do_build() {
  make -f Makefile-libbz2_so PREFIX="$pkg_prefix" CC="$CC"
  make bzip2 bzip2recover CC="$CC" LDFLAGS="$LDFLAGS"
}

do_check() {
  make test
}

do_install() {
  local maj maj_min
  maj=$(echo $pkg_version | cut -d "." -f 1)
  maj_min=$(echo $pkg_version | cut -d "." -f 1-2)

  make install PREFIX="$pkg_prefix"

  # Replace some hard links with symlinks
  rm -fv "$pkg_prefix/bin"/{bunzip2,bzcat}
  ln -sv bzip2 "$pkg_prefix/bin/bunzip2"
  ln -sv bzip2 "$pkg_prefix/bin/bzcat"

  # Install the shared library and its symlinks
  cp -v "$HAB_CACHE_SRC_PATH/$pkg_dirname/libbz2.so.$pkg_version" \
    "$pkg_prefix/lib"
  ln -sv "libbz2.so.$pkg_version" "$pkg_prefix/lib/libbz2.so"
  ln -sv "libbz2.so.$pkg_version" "$pkg_prefix/lib/libbz2.so.$maj"
  ln -sv "libbz2.so.$pkg_version" "$pkg_prefix/lib/libbz2.so.$maj_min"
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
