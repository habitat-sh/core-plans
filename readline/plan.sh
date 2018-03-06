pkg_name=readline
_distname="$pkg_name"
pkg_origin=core
_base_version=7.0
pkg_version=${_base_version}.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Readline library provides a set of functions for use by applications \
that allow users to edit command lines as they are typed in.\
"
pkg_upstream_url="http://tiswww.case.edu/php/chet/readline/rltop.html"
pkg_license=('GPL-3.0')
_url_base="http://ftp.gnu.org/gnu/${_distname}"
pkg_source="${_url_base}/${_distname}-${_base_version}.tar.gz"
pkg_shasum="750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334"
pkg_dirname="${_distname}-${_base_version}"
pkg_deps=(
  core/glibc
  core/ncurses
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/bison
  core/grep
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_begin() {
  # The maintainer of Readline only releases these patches to fix serious
  # issues, so any new official patches will be part of this build, which will
  # be reflected in the "tiny" or "patch" number of the version coordinate. In
  # other words, given 6 patches, the version of this Readline package would be
  # `MAJOR.MINOR.6`.

  # Source a file containing an array of patch URLs and an array of patch file
  # shasums
  source "${PLAN_CONTEXT}/readline-patches.sh"
}

do_download() {
  do_default_download

  # Download all patch files, providing the corresponding shasums so we can
  # skip re-downloading if already present and verified
  for i in $(seq 0 $((${#_patch_files[@]} - 1))); do
    p="${_patch_files[$i]}"
    download_file "$p" "$(basename "$p")" "${_patch_shasums[$i]}"
  done; unset i p
}

do_verify() {
  do_default_verify

  # Verify all patch files against their shasums
  for i in $(seq 0 $((${#_patch_files[@]} - 1))); do
    verify_file "$(basename "${_patch_files[$i]}")" "${_patch_shasums[$i]}"
  done; unset i
}

do_prepare() {
  do_default_prepare

  # Apply all patch files to the extracted source
  for p in "${_patch_files[@]}"; do
    build_line "Applying patch $(basename "$p")"
    patch -p0 -i "${HAB_CACHE_SRC_PATH}/$(basename "$p")"
  done

  # This patch is to make sure that `libncurses' is among the `NEEDED'
  # dependencies of `libreadline.so' and `libhistory.so'. Failing to do that,
  # applications linking against Readline are forced to explicitly link against
  # libncurses as well; in addition, this trick doesn't work when using GNU
  # ld's `--as-needed'.
  #
  # Thanks to:
  # https://github.com/NixOS/nixpkgs/blob/release-15.09/pkgs/development/libraries/readline/link-against-ncurses.patch
  build_line "Applying patch link-against-ncurses.patch"
  patch -p1 -i "${PLAN_CONTEXT}/../readline/link-against-ncurses.patch"
}

do_install() {
  do_default_install

  # An empty `bin/` directory gets made, which we don't need and is confusing
  rm -rf "${pkg_prefix:?}/bin"
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
    core/bison
    core/grep
  )
fi
