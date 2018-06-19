pkg_name=ncurses
pkg_origin=core
pkg_version=6.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
ncurses (new curses) is a programming library providing an application \
programming interface (API) that allows the programmer to write text-based \
user interfaces in a terminal-independent manner.\
"
pkg_upstream_url="https://www.gnu.org/software/ncurses/"
pkg_license=('ncurses')
pkg_source="http://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="aa057eeeb4a14d470101eff4597d5833dcef5965331be3528c08d99cebaa0d17"
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/bzip2
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --with-shared \
    --with-termlib \
    --with-cxx-binding \
    --with-cxx-shared \
    --without-ada \
    --enable-sigwinch \
    --enable-pc-files \
    --with-pkg-config-libdir="$pkg_prefix/lib/pkgconfig" \
    --enable-symlinks \
    --enable-widec \
    --enable-ext-colors \
    --without-debug \
    --with-normal \
    --enable-overwrite \
    --disable-rpath-hack
  make
}

do_install() {
  make install

  # Many packages that use Ncurses will compile just fine against the widechar
  # libraries, but won't know to look for them. Create linker scripts and
  # symbolic links to allow older and non-widec compatible programs to build
  # properly
  #
  # Thanks to: http://clfs.org/view/sysvinit/x86_64-64/final-system/ncurses.html
  local maj maj_min
  maj=$(echo ${pkg_version} | cut -d "." -f 1)
  maj_min=$(echo ${pkg_version} | cut -d "." -f 1-2)
  for x in curses ncurses form panel menu tinfo; do
    ln -sv lib${x}w.so "$pkg_prefix/lib/lib${x}.so"
    ln -sv lib${x}w.so "$pkg_prefix/lib/lib${x}.so.$maj"
    ln -sv lib${x}w.so "$pkg_prefix/lib/lib${x}.so.$maj_min"
    ln -sv ${x}w.pc "$pkg_prefix/lib/pkgconfig/${x}.pc"
  done
  ln -sfv libncursesw.so "$pkg_prefix/lib/libcursesw.so"
  ln -sfv libncursesw.a "$pkg_prefix/lib/libcursesw.a"
  ln -sfv libncursesw.a "$pkg_prefix/lib/libcurses.a"

  # Install the license, which comes from the README
  install -dv "$pkg_prefix/share/licenses"
  # shellcheck disable=SC2016
  grep -B 100 '$Id' README > "$pkg_prefix/share/licenses/LICENSE"
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
