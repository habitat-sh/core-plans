pkg_name=zlib-musl
_distname="zlib"
pkg_origin=core
pkg_version=1.2.11
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Compression library implementing the deflate compression method found in gzip \
and PKZIP.\
"
pkg_upstream_url="http://www.zlib.net/"
pkg_license=('zlib')
pkg_source="https://zlib.net/fossils/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1"
pkg_dirname="${_distname}-${pkg_version}"
pkg_license=('zlib')
pkg_deps=(
  core/musl
)
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=()
fi
