pkg_name=bc
pkg_origin=core
pkg_version=1.07.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://www.gnu.org/software/bc/"
pkg_description="bc is an arbitrary precision numeric processing language"
pkg_license=("GPL-3.0")
pkg_source="https://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a"
pkg_deps=(
  core/flex
  core/glibc
  core/ncurses
  core/readline
)
pkg_build_deps=(
  core/bison
  core/coreutils
  core/diffutils
  core/ed
  core/gcc
  core/make
  core/patch
  core/texinfo
)
pkg_bin_dirs=(bin)

do_prepare() {
	# Both fixes here thanks to:
	# http://www.linuxfromscratch.org/lfs/view/development/chapter06/bc.html

  sed -i -e '/flex/s/as_fn_error/: ;; # &/' configure

	cat > bc/fix-libmath_h << "EOF"
#!/bin/bash
sed -e '1   s/^/{"/' \
    -e     's/$/",/' \
    -e '2,$ s/^/"/'  \
    -e   '$ d'       \
    -i libmath.h

sed -e '$ s/$/0}/' \
    -i libmath.h
EOF
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-readline
  make
}

do_check() {
  echo "quit" | ./bc/bc -l Test/checklib.b
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_deps=(core/glibc core/readline)
  pkg_build_deps=(core/gcc core/coreutils)
fi
