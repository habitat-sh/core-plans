pkg_name=acl
pkg_origin=core
pkg_version=2.2.53
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Commands for Manipulating POSIX Access Control Lists."
pkg_upstream_url="https://savannah.nongnu.org/projects/acl"
pkg_license=('lgpl')
pkg_source="http://download.savannah.gnu.org/releases/$pkg_name/$pkg_name-${pkg_version}.tar.gz"
pkg_shasum="06be9865c6f418d851ff4494e12406568353b891ffe1f596b34693c387af26c7"
pkg_deps=(
  core/glibc
  core/attr
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/coreutils
  core/diffutils
  core/libtool
  core/patch
  core/make
  core/file
  core/gcc
  core/gettext
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  # Fix a bug that causes `getfacl -e` to segfault on overly long group name.
  #
  # Thanks to: http://www.linuxfromscratch.org/lfs/view/stable/chapter06/acl.html
  sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c

  # Update all references to the `/usr/bin/file` absolute path with `file`
  # which will be on `$PATH` due to file being a build dependency.
  grep -lr /usr/bin/file ./* | while read -r f; do
    sed -i -e "s,/usr/bin/file,file,g" "$f"
  done

  autoreconf -f -i
}

do_install() {
  make install
  chmod -v 755 "${pkg_prefix}/lib/libacl.so"
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
