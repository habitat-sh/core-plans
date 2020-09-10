source ../ncurses/plan.sh

pkg_name=ncurses5
pkg_origin=core
pkg_version=6.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The ncurses (new curses) library with version 5 API"
pkg_upstream_url="https://www.gnu.org/software/ncurses/"
pkg_license=('ncurses')
pkg_dirname="ncurses-${pkg_version}"
pkg_filename="${pkg_dirname}.tar.gz"
pkg_source="http://ftp.gnu.org/gnu/ncurses/${pkg_filename}"
pkg_shasum="aa057eeeb4a14d470101eff4597d5833dcef5965331be3528c08d99cebaa0d17"

do_build() {
  # API Version 5 doesn't compile with --enable-ext-colors
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
