pkg_name=linux
pkg_origin=core
pkg_version="4.11.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2')
pkg_source="https://cdn.kernel.org/pub/linux/kernel/v4.x/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="1ece864a5b0fbf448f6e01439968de7476c3bf57595c1c74cb96e9a2e3adbd0f"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc core/perl core/elfutils core/bc core/diffutils)

do_begin() {
  return 0
}

do_download() {
  do_default_download
}

do_verify() {
  do_default_verify
}

do_clean() {
  do_default_clean
}

do_unpack() {
  do_default_unpack
}

do_prepare() {
  return 0
}

do_build() {
  make defconfig INSTALL_PATH="$pkg_prefix"
  make
}

do_check() {
  return 0
}

do_install() {
  make INSTALL_MOD_PATH="$pkg_prefix" modules_install
  mkdir -p ${pkg_prefix}/boot
  cp -a arch/x86/boot/bzImage ${pkg_prefix}/boot/
}

do_strip() {
  do_default_strip
}

do_end() {
  return 0
}

