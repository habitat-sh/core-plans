pkg_name=ncdu
pkg_origin=core
pkg_version=1.15
pkg_license=('MIT')
pkg_description="Ncdu is a disk usage analyzer with an ncurses interface"
pkg_upstream_url=https://dev.yorhel.nl/ncdu
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://dev.yorhel.nl/download/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=4a593dc5cceb2492a9669f5f5d69d0e517de457a11036788ea4591f33c5297fb
pkg_deps=(core/glibc core/ncurses)
pkg_build_deps=(core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)

do_setup_environment() {
  export LDFLAGS="$LDFLAGS -Wl,--copy-dt-needed-entries"
}
