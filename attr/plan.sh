pkg_name=attr
pkg_origin=core
pkg_version=2.4.48
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Commands for Manipulating Filesystem Extended Attributes"
pkg_upstream_url=https://savannah.nongnu.org/projects/attr/
pkg_license=("GPL-2.0-or-later")
pkg_source="https://download.savannah.gnu.org/releases/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=5ead72b358ec709ed00bbf7a9eaef1654baad937c001c044fe8b74c57f5324e7
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/diffutils
  core/make
  core/gcc
  core/gettext
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_install() {
  make install
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
  )
fi
