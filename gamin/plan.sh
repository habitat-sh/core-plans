pkg_name=gamin
pkg_origin=core
pkg_version="0.1.10"
pkg_description="File Alteration Monitor"
pkg_upstream_url="https://people.gnome.org/~veillard/gamin/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=a59948b20ce2f14136c013f155abb8c8d51db2ea167c063ff33461e453fec10a
pkg_deps=(
  core/glib
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
  core/patch
  core/pcre
  core/pkg-config
  core/python2
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  # Can be removed once https://bugzilla.gnome.org/show_bug.cgi?id=658884 is fixed upstream
  patch -p1 < "${PLAN_CONTEXT}/patches/fix-deprecated-const.patch"
}
