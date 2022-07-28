pkg_name=groff
pkg_origin=core
pkg_version=1.22.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output. Output may be PostScript or PDF, html, or ASCII/UTF8 for display at the terminal. Formatting commands may be either low-level typesetting requests ("primitives") or macros from a supplied set. Users may also write their own macros. All three may be combined."
pkg_upstream_url=https://www.gnu.org/software/groff/
pkg_source=http://ftp.gnu.org/gnu/groff/groff-${pkg_version}.tar.gz
pkg_shasum=e78e7b4cb7dec310849004fa88847c44701e8d133b5d4c13057d876c1bad0293
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/gcc
  core/gcc-libs
  core/make
  core/perl
  core/texinfo
)
pkg_deps=(
  core/gcc-libs
  core/perl
)
