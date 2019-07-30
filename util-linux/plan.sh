pkg_name=util-linux
pkg_origin=core
pkg_version=2.34
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Miscellaneous system utilities for Linux"
pkg_upstream_url="https://www.kernel.org/pub/linux/utils/util-linux"
pkg_license=('GPLv2-or-later')
pkg_source="https://www.kernel.org/pub/linux/utils/${pkg_name}/v${pkg_version%.?}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="743f9d0c7252b6db246b659c1e1ce0bd45d8d4508b4dfa427bbb4a3e9b9f62b5"
pkg_deps=(
  core/glibc
  core/zlib
  core/ncurses
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

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --sbindir="$pkg_prefix/bin" \
    --localstatedir="$pkg_svc_var_path/run" \
    --without-python \
    --without-slang \
    --without-systemd \
    --without-systemdsystemunitdir \
    --disable-use-tty-group \
    --disable-chfn-chsh \
    --disable-login \
    --disable-nologin \
    --disable-su \
    --disable-setpriv \
    --disable-runuser \
    --disable-pylibmount
  make
}

do_install() {
  make install usrsbin_execdir="$pkg_prefix/bin"
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
