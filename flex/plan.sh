pkg_name=flex
pkg_origin=core
pkg_version=2.6.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
flex is a tool for generating scanners: programs which recognize lexical \
patterns in text.\
"
pkg_upstream_url="https://github.com/westes/flex"
pkg_license=('custom')
pkg_source="https://github.com/westes/$pkg_name/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/m4
  core/bison
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_check() {
  # Set `LDFLAGS` for the c++ test code to find libstdc++
  make check LDFLAGS="$LDFLAGS -lstdc++"
}

do_install() {
  do_default_install

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
