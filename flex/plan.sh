pkg_name=flex
pkg_origin=core
pkg_version=2.6.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Flex is a fast lexical analyser generator. It is a tool for generating programs that perform pattern-matching on text. Flex is a free (but non-GNU) implementation of the original Unix lex program."
pkg_license=('custom')
pkg_upstream_url="https://www.gnu.org/software/flex/"
pkg_source=https://github.com/westes/flex/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/m4 core/bison)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  CFLAGS="${CFLAGS} -D_GNU_SOURCE"
  build_line "Updating CFLAGS=$CFLAGS"
}

do_check() {
  # Set `LDFLAGS` for the c++ test code to find libstdc++
  make check LDFLAGS="$LDFLAGS -lstdc++"
}

do_build() {
  CFLAGS="${CFLAGS} -D_GNU_SOURCE"

  do_default_build
}

do_install() {
  do_default_install

  install --mode 0644 COPYING "$pkg_prefix"/

  # A few programs do not know about `flex` yet and try to run its predecessor,
  # `lex`
  ln -sv flex "$pkg_prefix/bin/lex"
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
    core/m4
    core/coreutils
    core/bison
  )
fi
