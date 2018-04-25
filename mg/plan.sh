pkg_name=mg
pkg_origin=core
pkg_version=20171014
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
mg is Micro GNU/emacs, this is a portable version of the mg maintained by the \
OpenBSD team.\
"
pkg_upstream_url="https://homepage.boetes.org/software/mg/"
pkg_license=('publicdomain')
pkg_source="http://homepage.boetes.org/software/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="51519698f3f44acd984d7805e4e315ded50c15aba8222521f88756fd67745341"
pkg_deps=(
  core/glibc
  core/ncurses
  core/libbsd
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
  core/pkg-config
  core/clens
)
pkg_bin_dirs=(bin)

do_prepare() {
  # shellcheck disable=SC2002
  cat "$PLAN_CONTEXT/cleanup.patch" \
    | sed \
      -e "s,@prefix@,$pkg_prefix,g" \
      -e "s,@clens_prefix@,$(pkg_path_for clens),g" \
      -e "s,@libbsd_prefix@,$(pkg_path_for libbsd),g" \
    | patch -p1
}

do_build() {
  make \
    prefix="$pkg_prefix" \
    PKG_CONFIG=pkg-config \
    INSTALL=install \
    STRIP=strip
}

do_install() {
  do_default_install

  # Install license file from README
  install -Dm644 README "$pkg_prefix/share/licenses/README"
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
    core/pkg-config
    core/coreutils
    core/sed
    core/diffutils
    core/make
    core/patch
    core/clens
  )
fi
