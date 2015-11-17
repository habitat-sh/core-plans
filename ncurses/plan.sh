pkg_name=ncurses
pkg_derivation=chef
pkg_version=5.9
pkg_license=('ncurses')
pkg_source=http://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
pkg_shasum=9046298fb440324c9d4135ecea7879ffed8546dd1b58e59430ea07a4633f563b
pkg_gpg_key=3853DA6B
pkg_deps=(chef/glibc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

build() {
  ./configure --prefix=$pkg_prefix \
    --with-shared \
    --with-termlib \
    --with-cxx-binding \
    --with-cxx-shared \
    --without-ada \
    --enable-sigwinch \
    --enable-pc-files \
    --enable-symlinks \
    --enable-widec \
    --without-debug \
    --without-normal \
    --enable-overwrite
  make
}

install() {
  make install
  for x in libform libmenu libncurses libtinfo libpanel; do
    ln -s $pkg_prefix/lib/${x}w.so $pkg_prefix/lib/${x}.so
    ln -s $pkg_prefix/lib/${x}w.so $pkg_prefix/lib/${x}.so.5
    ln -s $pkg_prefix/lib/${x}w.so $pkg_prefix/lib/${x}.so.5.9
  done
}
