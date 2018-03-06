source ../bash/plan.sh

pkg_name=bash-static
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
 Bash is the GNU Project's shell. Bash is the Bourne Again SHell. Bash is an \
sh-compatible shell that incorporates useful features from the Korn shell \
(ksh) and C shell (csh). It is intended to conform to the IEEE POSIX \
P1003.2/ISO 9945.2 Shell and Tools standard. It offers functional \
improvements over sh for both programming and interactive use. In addition, \
most sh scripts can be run by Bash without modification.\
"
pkg_upstream_url="http://www.gnu.org/software/bash/bash.html"
pkg_license=('gplv3+')
pkg_dirname=${_distname}-$_base_version

# Throw the run deps into build deps as this will be static
pkg_build_deps=(
  "${pkg_deps[@]}"
  "${pkg_build_deps[@]}"
)
# Empty out the run deps array
pkg_deps=()

do_begin() {
  PLAN_CONTEXT=$(abspath ../bash)
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-curses \
    --enable-readline \
    --without-bash-malloc \
    --with-installed-readline="$(pkg_path_for core/readline)" \
    LDFLAGS="-static $LDFLAGS"

  # Link `-ltinfow` rather than `-lcurses` as some symbols appear to have moved
  # in ncurses 6.x codebase.
  #
  # Thanks to: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=650349
  sed -e "s,^TERMCAP_LIB = -lcurses$,TERMCAP_LIB = -ltinfow," -i Makefile

  make LDFLAGS="-static $LDFLAGS"
}
