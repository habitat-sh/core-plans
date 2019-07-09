pkg_name=bison2
pkg_distname=bison
pkg_origin=core
pkg_version=2.7.1
pkg_description="A parser generator that converts an annotated context-free grammar into a parser"
pkg_upstream_url=https://www.gnu.org/software/bison/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_distname/${pkg_distname}-${pkg_version}.tar.xz
pkg_filename=${pkg_distname}-${pkg_version}.tar.xz
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_shasum=b409adcbf245baadb68d2f66accf6fdca5e282cafec1b865f4b5e963ba8ea7fb
pkg_deps=(core/glibc core/m4)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/perl)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
