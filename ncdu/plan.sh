pkg_name=ncdu
pkg_origin=core
pkg_version=1.16
pkg_license=('MIT')
pkg_description="Ncdu is a disk usage analyzer with an ncurses interface"
pkg_upstream_url=https://dev.yorhel.nl/ncdu
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://dev.yorhel.nl/download/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=2b915752a183fae014b5e5b1f0a135b4b408de7488c716e325217c2513980fd4
pkg_deps=(core/glibc core/ncurses)
pkg_build_deps=(core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)

do_setup_environment() {
  export LDFLAGS="$LDFLAGS -Wl,--copy-dt-needed-entries"
}
