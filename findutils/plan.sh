pkg_name=findutils
pkg_origin=core
pkg_version=4.9.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Find Utilities are the basic directory searching utilities of the GNU \
operating system. These programs are typically used in conjunction with other \
programs to provide modular and powerful directory search and file locating \
capabilities to other commands.\
"
pkg_upstream_url="http://www.gnu.org/software/findutils"
pkg_license=('GPL-3.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="a2bfb8c09d436770edc59f50fa483e785b161a3b7b9d547573cb08065fd462fe"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
  core/pkg-config
  core/m4
  core/autoconf
  core/automake
)
pkg_bin_dirs=(bin)

do_prepare() {
  # Glibc 2.28 removed headers that findutils expects.
  # These patches correct findutils to allow it to build with
  # the latest glibc.
  # Thanks to Arch Linux for pulling these together
  # https://git.archlinux.org/svntogit/packages.git/tree/trunk?h=packages/findutils
    
  # The Makefiles were generated with aclocal-1.14, and the above patches
  # force it to want to regenerate. The following four lines can be removed
  # if findutils releases a new version that no longer requries the patches
  ACLOCAL_PATH="$ACLOCAL_PATH:$(pkg_path_for core/autoconf)/share/autoconf"
  ACLOCAL_PATH="$ACLOCAL_PATH:$HAB_CACHE_SRC_PATH/$pkg_dirname/m4"
  export ACLOCAL_PATH
  aclocal
}

do_build() {

  automake --add-missing
  ./configure \
    --prefix="$pkg_prefix" \
    --localstatedir="$pkg_svc_var_path/locate"
  make
}

do_check() {
  make check
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
  )
fi
