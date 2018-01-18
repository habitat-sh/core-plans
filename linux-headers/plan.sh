pkg_name=linux-headers
pkg_origin=core
pkg_version=4.14.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2')
pkg_source=https://www.kernel.org/pub/linux/kernel/v4.x/linux-${pkg_version}.tar.xz
pkg_description="The Linux kernel headers"
pkg_upstream_url="https://kernel.org"
pkg_shasum=cfccbb448d337761127aac28caba8f5649683c645f84b59b6e446b6e06a414ef
pkg_dirname=linux-$pkg_version
pkg_deps=()
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc)
pkg_include_dirs=(include)

do_build() {
  make headers_install ARCH=x86 INSTALL_HDR_PATH="$pkg_prefix"
}

do_install() {
  find "$pkg_prefix/include" \( -name ..install.cmd -o -name .install \) -print0 | xargs -0 rm -v
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
