pkg_name=musl
pkg_origin=core
pkg_version=1.1.18
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="musl is a new standard library to power a new generation of Linux-based devices. musl is lightweight, fast, simple, free, and strives to be correct in the sense of standards-conformance and safety."
pkg_upstream_url="https://www.musl-libc.org/"
pkg_source="http://www.musl-libc.org/releases/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="d017ee5d01aec0c522a1330fdff06b1e428cb409e1db819cc4935d5da4a5a118"
pkg_deps=()
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/gcc
  core/make
  core/patch
  core/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  stack_size="2097152"
  build_line "Setting default stack size to '$stack_size' from default of '81920'"
  sed -i'' "s/#define DEFAULT_STACK_SIZE .*/#define DEFAULT_STACK_SIZE $stack_size/" \
    src/internal/pthread_impl.h
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --syslibdir="$pkg_prefix/lib"
  make -j "$(nproc)"
}

do_install() {
  do_default_install

  # Install license
  install -Dm0644 COPYRIGHT "$pkg_prefix/share/licenses/COPYRIGHT"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(core/gcc core/coreutils core/sed core/diffutils core/make core/patch)
fi
