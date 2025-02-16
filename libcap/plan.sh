pkg_name=libcap
pkg_origin=core
pkg_version=2.60
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="POSIX 1003.1e capabilities."
pkg_upstream_url="http://sites.google.com/site/fullycapable/"
pkg_license=('gplv2')
pkg_source="https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="06a92076ce39a78bd28089e32085f1bde7f3bfa448fad37d895c2358f760b2eb"
pkg_deps=(
  core/glibc
  core/attr
)
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
  core/linux-headers
  core/perl
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  do_default_prepare

  # Install binaries under `bin/` vs. `sbin/`
  sed -i "/SBINDIR/s#/$(sbin)#bin#" Make.Rules
}

do_build() {
  make KERNEL_HEADERS="$(pkg_path_for linux-headers)/include" LDFLAGS="$LDFLAGS"
}

do_install() {
  make prefix="$pkg_prefix" lib=lib RAISE_SETFCAP=no install
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
    core/linux-headers
  )
fi
