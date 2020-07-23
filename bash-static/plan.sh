source ../bash/plan.sh

pkg_name=bash-static
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Bash is the GNU Project's shell. Bash is the Bourne Again SHell."
pkg_upstream_url=http://www.gnu.org/software/bash/bash.html
pkg_license=("GPL-3.0-or-later")
pkg_dirname="${_distname}-${_base_version}"

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
    --prefix="${pkg_prefix}" \
    --with-curses \
    --enable-readline \
    --without-bash-malloc \
    --with-installed-readline="$(pkg_path_for core/readline)" \
    LDFLAGS="-static ${LDFLAGS}"

  # Link `-ltinfow` rather than `-lcurses` as some symbols appear to have moved
  # in ncurses 6.x codebase.
  #
  # Thanks to: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=650349
  sed -e "s,^TERMCAP_LIB = -lcurses$,TERMCAP_LIB = -ltinfow," -i Makefile

  make LDFLAGS="-static ${LDFLAGS}"
}
