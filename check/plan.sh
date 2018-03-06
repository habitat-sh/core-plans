pkg_name=check
pkg_origin=core
pkg_version=0.12.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Check is a unit testing framework for C. It features a simple interface for \
defining unit tests, putting little in the way of the developer. Tests are run \
in a separate address space, so both assertion failures and code errors that \
cause segmentation faults or other signals can be caught.\
"
pkg_upstream_url="https://libcheck.github.io/check"
pkg_license=('LGPL-2.1-or-later')
pkg_source="https://github.com/libcheck/check/releases/download/${pkg_version}/check-${pkg_version}.tar.gz"
pkg_shasum="464201098bee00e90f5c4bdfa94a5d3ead8d641f9025b560a27755a83b824234"
pkg_deps=(
  core/gawk
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/file
  core/gcc
  core/make
  core/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  # Update all references to the `/usr/bin/file` absolute path with `file`
  # which will be on `$PATH` due to file being a build dependency.
  sed -i -e "s,/usr/bin/file,file,g" ./configure
}

do_check() {
  # Fix interpreters for test scripts
  _interpreter="$(pkg_path_for "core/coreutils")/bin/env"
  sed -e "s#\#\!/usr/bin/env#\#\!${_interpreter}#" \
    -i "checkmk/test/check_checkmk"
  for f in tests/test_*; do
    sed -e "s#\#\!/usr/bin/env#\#\!${_interpreter}#" -i "$f"
  done

  make check
}

do_install() {
  do_default_install

  # Clean up extra files
  rm -rfv "${pkg_prefix}/share/info/dir" \
    "${pkg_prefix}/share/doc/check/*ChangeLog*"
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
    core/file
  )
fi
