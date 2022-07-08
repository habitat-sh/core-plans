pkg_name=xz-musl
_distname="xz"
pkg_origin=core
pkg_version=5.2.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
XZ Utils is free general-purpose data compression software with a high \
compression ratio. XZ Utils were written for POSIX-like systems, but also \
work on some not-so-POSIX systems. XZ Utils are the successor to LZMA Utils.\
"
pkg_upstream_url="http://tukaani.org/xz/"
pkg_license=('gpl2+' 'lgpl2+')
pkg_source="http://tukaani.org/${_distname}/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="f6f4910fd033078738bd82bfba4f49219d03b17eb0794eb91efbae419f4aba10"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/musl
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  make check
}

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
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
  )
fi
