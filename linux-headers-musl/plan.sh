pkg_name=linux-headers-musl
pkg_origin=core
pkg_version=3.12.6-6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Linux kernel headers (sanitized for use with musl)."
pkg_upstream_url="https://github.com/sabotage-linux/kernel-headers"
pkg_license=('MIT')
pkg_source="https://github.com/sabotage-linux/kernel-headers/archive/v${pkg_version}.tar.gz"
pkg_shasum="e173fc8db34660a368c1692b3cea2b8a3b2affb3c193ae7195aa251bc1497d57"
pkg_dirname="kernel-headers-${pkg_version}"
pkg_deps=()
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/gcc
  core/make
  core/patch
)
pkg_include_dirs=(include)

do_build() {
  make \
    ARCH=x86_64 \
    prefix="${pkg_prefix}"
}

do_install() {
  make \
    ARCH=x86_64 \
    prefix="${pkg_prefix}" \
    install
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
    core/diffutils
    core/make
    core/patch
  )
fi
