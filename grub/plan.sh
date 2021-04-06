pkg_name=grub
pkg_origin=core
pkg_version=2.04
pkg_source=ftp://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GNU GRUB is a Multiboot boot loader."
pkg_shasum="e5292496995ad42dabe843a0192cf2a2c502e7ffcc7479398232b10a472df77d"
pkg_upstream_url=https://www.gnu.org/software/grub/
pkg_license=('GPL-3.0')
pkg_bin_dirs=(bin sbin)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/binutils
  core/bison
  core/cacerts
  core/diffutils
  core/dosfstools
  core/flex
  core/zlib
  core/libpng
  core/freetype
  core/gcc
  core/gettext
  core/git
  core/m4
  core/make
  core/python
  core/qemu
  core/rsync
  core/texinfo
  core/patch
)
pkg_deps=(core/glibc core/xz core/gettext core/pcre core/gcc-libs core/devicemapper core/elfutils core/bzip2 core/libcap)

do_setup() {
  if [[ ! -d /boot ]]; then
    mkdir /boot
    _GRUB_CLEANUP_BOOT="yes"
  fi
}

do_prepare() {
  #patch -Np1 < "${PLAN_CONTEXT}/patches/001-fix-packed-not-aligned-error-on-GCC-8.patch"
}

do_build() {
  sed -i "s/#! \/usr\/bin\/env bash/#!\/bin\/bash/" ./autogen.sh

  ./linguas.sh
  ./autogen.sh
  ./configure \
  --prefix="${pkg_prefix}" \
  --with-bootdir="/boot" \
  --target="x86_64" \
  --enable-efiemu \
  --enable-mm-debug \
  --enable-nls \
  --enable-device-mapper \
  --enable-cache-stats \
  --enable-boot-time \
  --enable-grub-mkfont \
  --with-grubdir="grub" \
  --disable-silent-rules \
  --disable-werror

  make -j "$(nproc)"
}

do_check() {
  make -j "$(nproc)" check
}

do_after() {
  if [[ -n "${_GRUB_CLEANUP_BOOT}" ]]; then
    # Although this looks dangerous, it shouldn't be
    # because this should only every run in a habitat studio environment and
    # the /boot directory is both created and destroyed by the plan
    # shellcheck disable=SC2114
    rm -rf /boot
    info "Cleanup /boot"
  fi
}
