pkg_name=zsh
pkg_origin=core
pkg_version=5.8
pkg_description="Zsh is a shell designed for interactive use, although it is also a powerful scripting language."
pkg_upstream_url="http://www.zsh.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('zsh')
pkg_source="https://downloads.sourceforge.net/project/zsh/zsh/${pkg_version}/zsh-${pkg_version}.tar.xz"
pkg_shasum=dcc4b54cc5565670a65581760261c163d720991f0d06486da61f8d839b52de27
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
    --enable-zsh-secure-free \
    --with-tcsetpgrp
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
