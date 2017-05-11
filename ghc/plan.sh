# Used Arch Linux GHC PKGBUILD as reference for this plan:
# https://git.archlinux.org/svntogit/community.git/tree/trunk/PKGBUILD?h=packages/ghc&id=b099a18658e353d77ca5df5c333aabc03fdab06b

pkg_name=ghc
pkg_origin=core
pkg_version="8.0.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_upstream_url=https://www.haskell.org/ghc/
pkg_description="The Glasgow Haskell Compiler"
pkg_source="http://downloads.haskell.org/~${pkg_name}/${pkg_version}/${pkg_name}-${pkg_version}-src.tar.xz"
pkg_filename="${pkg_name}-${pkg_version}-src.tar.xz"
pkg_shasum="11625453e1d0686b3fa6739988f70ecac836cadc30b9f0c8b49ef9091d6118b1"

# libffi should remove directories with version in path
_libffi_version=3.2.1

pkg_deps=(
  core/perl
  core/gcc
  core/gmp
  core/glibc
  core/libffi/${_libffi_version}
  core/libedit
  core/libiconv
  core/ncurses
)

pkg_build_deps=(
  dmp1ce/ghc
  core/diffutils
  core/patch
  core/make
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_prepare() {
  # Select the following build profile:
  #   Full build with max optimisation and everything enabled (very slow build)
  cp mk/build.mk{.sample,}
  sed -i '1iBuildFlavour = perf' mk/build.mk
}

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --docdir="${pkg_prefix}/doc" \
    --with-system-libffi \
    --with-ffi-libraries="$(pkg_path_for core/libffi)/lib" \
    --with-ffi-includes="$(pkg_path_for core/libffi)/lib/libffi-${_libffi_version}/include" \
    --with-curses-includes="$(pkg_path_for core/ncurses)/include" \
    --with-curses-libraries="$(pkg_path_for core/ncurses)/lib" \
    --with-gmp-includes="$(pkg_path_for core/gmp)/include" \
    --with-gmp-libraries="$(pkg_path_for core/gmp)/lib" \
    --with-iconv-includes="$(pkg_path_for core/libiconv)/include" \
    --with-iconv-libraries="$(pkg_path_for core/libiconv)/lib"
  make
}

do_install() {
  do_default_install

  # Install bash-completion files
  install -Dm644 utils/completion/ghc.bash "${pkg_prefix}/bash-completion/ghc.bash"
}
