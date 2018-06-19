pkg_name=pkg-config
pkg_origin=core
pkg_version=0.29.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
pkg-config is a helper tool used when compiling applications and libraries. \
It helps you insert the correct compiler options on the command line so an \
application can use a call to pkg-config for instance, rather than \
hard-coding values on where to find glib (or other libraries).\
"
pkg_upstream_url="http://pkgconfig.freedesktop.org/wiki/"
pkg_license=('gplv2+')
pkg_source="http://pkgconfig.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-internal-glib \
    --disable-host-tool
  make
}

do_check() {
  make check
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
  )
fi
