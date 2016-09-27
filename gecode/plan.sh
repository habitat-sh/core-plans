pkg_name=gecode
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=3.7.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="http://www.gecode.org/download/gecode-${pkg_version}.tar.gz"
pkg_shasum=e7cc8bcc18b49195fef0544061bdd2e484a1240923e4e85fa39e8d6bb492854c
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(
  core/gcc
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/gcc
  core/make
  core/perl
)
pkg_description="Gecode is a toolkit for developing constraint-based systems and applications"
pkg_upstream_url="http://www.gecode.org"
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
  ./configure \
           --prefix="$pkg_prefix" \
           --disable-doc-dot \
           --disable-doc-search \
           --disable-doc-tagfile \
           --disable-doc-chm \
           --disable-doc-docset \
           --disable-qt \
           --disable-examples

  make -j "$(nproc)"
}

do_check() {
  LD_LIBRARY_PATH=$PWD make check
}
