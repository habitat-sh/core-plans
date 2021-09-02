pkg_name=nload
pkg_description="Real time network traffic monitor for the text console"
pkg_origin=core
pkg_version="0.7.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0-or-later")
pkg_source="https://github.com/rolandriegel/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="a73b3a75356776860fc4c40daebce04c5022f73d39704a12fb0aeb88a751216a"
pkg_upstream_url="https://github.com/rolandriegel/nload"
pkg_build_deps=(core/make core/gcc core/automake core/autoconf)
pkg_deps=(core/glibc core/gcc-libs core/ncurses)
pkg_bin_dirs=(bin)

do_prepare() {
  autoupdate
  export LDFLAGS="$LDFLAGS -Wl,--copy-dt-needed-entries"
  ./run_autotools
}
