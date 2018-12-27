pkg_name=zsh
pkg_origin=core
pkg_version=5.6.2
pkg_description="Zsh is a shell designed for interactive use, although it is also a powerful scripting language."
pkg_upstream_url="http://www.zsh.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('zsh')
pkg_source="https://downloads.sourceforge.net/project/zsh/zsh/${pkg_version}/zsh-${pkg_version}.tar.xz"
pkg_shasum=a50bd66c0557e8eca3b8fa24e85d0de533e775d7a22df042da90488623752e9e
pkg_deps=(
  core/coreutils
  core/gdbm
  core/glibc
  core/pcre
  core/ncurses
  core/perl
  core/readline
)
pkg_build_deps=(
  core/busybox-static
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/zsh)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-multibyte \
    --enable-cap \
    --enable-pcre \
    --enable-etcdir="${pkg_prefix}/etc" \
    --enable-zsh-secure-free
  make
}

do_install() {
  make install
  mkdir -p "${pkg_prefix}/etc"
  cp "${PLAN_CONTEXT}/zprofile" "${pkg_prefix}/etc"
}

do_check() {
  make check
}
