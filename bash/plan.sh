pkg_name=bash
_distname="${pkg_name}"
pkg_origin=core
_base_version=5.0
pkg_version="${_base_version}.16"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Bash is the GNU Project's shell. Bash is the Bourne Again SHell."
pkg_upstream_url=https://www.gnu.org/software/bash/bash.html
pkg_license=("GPL-3.0-or-later")
_url_base="https://ftp.gnu.org/gnu/${_distname}"
pkg_source="${_url_base}/${_distname}-${_base_version}.tar.gz"
pkg_shasum=b4a80f2ac66170b2913efbfb9f2594f1f76c7b1afd11f799e22035d63077fb4d
pkg_dirname="${_distname}-${_base_version}"
pkg_deps=(
  core/glibc
  core/ncurses
  core/readline
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/perl
)
pkg_bin_dirs=(bin)
pkg_interpreters=(
  bin/bash
  bin/sh
)

do_begin() {
  # The maintainer of Bash only releases these patches to fix serious issues,
  # so any new official patches will be part of this build, which will be
  # reflected in the "tiny" or "patch" number of the version coordinate. In
  # other words, given 6 patches, the version of this Bash package would be
  # `MAJOR.MINOR.6`.

  # Source a file containing an array of patch URLs and an array of patch file
  # shasums
  source "${PLAN_CONTEXT}/bash-patches.sh"
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
    build_line "Applying patch $(basename "${p}")"
    patch -p0 -i "${HAB_CACHE_SRC_PATH}/$(basename "${p}")"
  done
}

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-curses \
    --enable-readline \
    --without-bash-malloc \
    --with-installed-readline="$(pkg_path_for readline)"
  make
}

do_check() {
  # This test suite hard codes several commands out of coreutils, so we'll add
  # those as symlinks before the tests.
  local clean_cmds=()
  for cmd in /bin/rm /bin/cat /bin/touch /bin/chmod /usr/bin/printf /bin/echo; do
    if [[ ! -r "${cmd}" ]]; then
      ln -sv "$(pkg_path_for coreutils)/bin/$(basename "${cmd}")" "${cmd}"
      clean_cmds+=("${cmd}")
    fi
  done

  make tests

  # Clean up any symlinks that were added to support the test suite.
  for cmd in "${clean_cmds[@]}"; do
    rm -fv "${cmd}"
  done
}

do_install() {
  do_default_install

  # Add an `sh` which symlinks to `bash`
  ln -sv bash "${pkg_prefix}/bin/sh"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "${STUDIO_TYPE}" = "stage1" ]]; then
  pkg_build_deps=(
    core/gcc
    core/coreutils
  )
fi
