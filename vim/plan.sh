pkg_name=vim
pkg_origin=core
pkg_version=8.0.1542
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Vim is a highly configurable text editor built to make creating and changing \
any kind of text very efficient. It is included as "vi" with most UNIX \
systems and with Apple OS X.\
"
pkg_upstream_url="http://www.vim.org/"
pkg_license=("Vim")
pkg_source="http://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="d0818df5c6da23db725aa68067c90c80f0779c2e3446811bd1389b1ac2c2df86"
pkg_deps=(
  core/acl
  core/attr
  core/glibc
  core/ncurses
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
  core/autoconf
)
pkg_bin_dirs=(bin)

do_prepare() {
  pushd src > /dev/null
    autoconf
  popd > /dev/null

  export CPPFLAGS="$CPPFLAGS $CFLAGS -O2"
  build_line "Setting CPPFLAGS=$CPPFLAGS"
}

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-compiledby="Habitat, vim release ${pkg_version}" \
    --with-features=huge \
    --enable-acl \
    --with-x=no \
    --disable-gui \
    --enable-multibyte
  make
}

do_install() {
  do_default_install

  # Add a `vi` which symlinks to `vim`
  ln -sv vim "${pkg_prefix}/bin/vi"

  # Install license file
  install -Dm644 runtime/doc/uganda.txt "${pkg_prefix}/share/licenses/license.txt"
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
    core/autoconf
  )
fi
