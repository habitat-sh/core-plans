pkg_name=dejagnu
pkg_origin=core
pkg_version=1.6.3
pkg_license=('GPL-3.0-or-later')
pkg_upstream_url="https://www.gnu.org/software/dejagnu/"
pkg_description="A framework for testing other programs."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="87daefacd7958b4a69f88c6856dbd1634261963c414079d0c371f589cd66a2e3"
pkg_deps=(
  core/expect
  core/coreutils
  core/sed
  core/grep
)
pkg_build_deps=(
  core/diffutils
  core/patch
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)

do_check() {
  make check
}

do_install() {
  do_default_install

  # Set an absolute path `expect` in the `runtest` binary
  sed \
    -e "s,expectbin=expect,expectbin=$(pkg_path_for expect)/bin/expect,g" \
    -i "$pkg_prefix/bin/runtest"
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
    core/coreutils
    core/sed
    core/diffutils
    core/make
    core/patch
  )
fi
