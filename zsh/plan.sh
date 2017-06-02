pkg_name=zsh
pkg_origin=core
pkg_version=5.3.1
pkg_description="Zsh is a shell designed for interactive use, although it is also a powerful scripting language."
pkg_upstream_url="http://www.zsh.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('zsh')
pkg_source=https://downloads.sourceforge.net/project/zsh/zsh/$pkg_version/zsh-$pkg_version.tar.gz
pkg_shasum=3d94a590ff3c562ecf387da78ac356d6bea79b050a9ef81e3ecb9f8ee513040e
pkg_deps=(core/glibc core/pcre core/ncurses core/readline core/gdbm core/coreutils core/perl)
pkg_build_deps=(core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/zsh)

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --enable-multibyte \
    --enable-cap \
    --enable-pcre \
    --enable-etcdir="$pkg_prefix/etc" \
    --enable-zsh-secure-free
  make
}

do_install() {
  make install
  mkdir -p "$pkg_prefix/etc"
  cp "$PLAN_CONTEXT/zprofile" "$pkg_prefix/etc"
}

do_check() {
  make check
}
