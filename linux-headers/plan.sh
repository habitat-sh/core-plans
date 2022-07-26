pkg_name=linux-headers
pkg_origin=core
pkg_version=4.20.17
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Linux kernel headers"
pkg_upstream_url="https://kernel.org"
pkg_license=('GPL-2.0-or-later')
pkg_source="https://www.kernel.org/pub/linux/kernel/v4.x/linux-${pkg_version}.tar.xz"
pkg_shasum="d011245629b980d4c15febf080b54804aaf215167b514a3577feddb2495f8a3e"
pkg_dirname="linux-$pkg_version"
pkg_deps=()
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
)
pkg_include_dirs=(include)

do_build() {
  make headers_install ARCH=x86 INSTALL_HDR_PATH="$pkg_prefix"
}

do_install() {
  find "$pkg_prefix/include" \
    \( -name ..install.cmd -o -name .install \) \
    -print0 \
  | xargs -0 rm -v
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
