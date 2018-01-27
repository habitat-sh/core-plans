pkg_name=less
pkg_origin=core
pkg_version=487
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="a terminal pager program used to view (but not change) the contents of a text file"
pkg_license=('gplv3+')
pkg_upstream_url="http://www.greenwoodsoftware.com/less/index.html"
pkg_source=http://www.greenwoodsoftware.com/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=f3dc8455cb0b2b66e0c6b816c00197a71bf6d1787078adeee0bcf2aea4b12706
pkg_deps=(core/glibc core/ncurses core/pcre)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc)
pkg_bin_dirs=(bin)

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --sysconfdir=/etc \
    --with-regex=pcre
  make
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(core/gcc core/coreutils)
fi
