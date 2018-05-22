pkg_name=ncurses5-compat-libs
pkg_origin=core
pkg_version=6.0
pkg_description="The ncurses (new curses) library with version 5 API"
pkg_upstream_url=https://www.gnu.org/software/ncurses/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('ncurses')
pkg_dirname=ncurses-${pkg_version}
pkg_filename=${pkg_dirname}.tar.gz
pkg_source=http://ftp.gnu.org/gnu/ncurses/${pkg_filename}
pkg_shasum=f551c24b30ce8bfb6e96d9f59b42fbea30fa3a6123384172f9e7284bcf647260
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/wget core/bzip2)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  wget http://invisible-mirror.net/archives/ncurses/6.0/ncurses-6.0-20160910-patch.sh.bz2
  bzip2 -d ncurses-6.0-20160910-patch.sh.bz2

  sh ncurses-6.0-20160910-patch.sh

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
    --disable-rpath-hack \
    --with-abi-version=5
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
  for x in curses ncurses form panel menu tinfo; do
    ln -sv lib${x}w.so "$pkg_prefix/lib/lib${x}.so"
    ln -sv lib${x}w.so "$pkg_prefix/lib/lib${x}.so.5"
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
  pkg_build_deps=(core/gcc)
fi
