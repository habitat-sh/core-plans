pkg_name=patchelf
pkg_origin=core
pkg_version=0.13
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
A small utility to modify the dynamic linker and RPATH of ELF executables.\
"
pkg_upstream_url="https://nixos.org/patchelf.html"
pkg_license=('GPL-3.0-or-later')
pkg_source="https://github.com/NixOS/patchelf/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum=60c6aeadb673de9cc1838b630c81f61e31c501de324ef7f1e8094a2431197d09
#pkg_dirname="${pkg_name}-${pkg_version}.20200609.d6b2a72"
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
	core/autoconf
	core/automake
)
pkg_bin_dirs=(bin)

if [[ -n "$FIRST_PASS" ]]; then
  # Waiting on gcc-libs to link libgcc and libstdc++, but because we need
  # this package to prepare gcc-libs, we'll do the cheap version first
  # that relies on the full gcc version of these shared libraries
  pkg_deps=(
    core/glibc
    core/gcc
  )
else
  pkg_deps=(
    core/glibc
    core/gcc-libs
  )
fi

do_begin() {
  if [[ -n "$FIRST_PASS" ]]; then
    build_line "Using libgcc and libstdc++ from core/gcc"
  fi
}

# updating build steps with v0.13
do_build() {
	./bootstrap.sh
	./configure
	make
}

do_check() {
	make check
}

do_install() {
	build_line "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/src/${pkg_name}"
	build_line "${pkg_prefix}/bin/"
	cp "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/src/${pkg_name}" "${pkg_prefix}/bin/"
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
