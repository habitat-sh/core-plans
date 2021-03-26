pkg_name=libxcomposite
pkg_origin=core
pkg_version=0.4.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 C Bindings for Composite extension"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_dirname="libXcomposite-${pkg_version}"
pkg_source="https://www.x.org/releases/individual/lib/${pkg_dirname}.tar.bz2"
pkg_shasum="b3218a2c15bab8035d16810df5b8251ffc7132ff3aa70651a1fba0bfe9634e8f"
pkg_deps=(
  core/glibc
  core/libxau
  core/libxcb
  core/libxdmcp
  core/xlib
)
pkg_build_deps=(
  core/compositeproto
  core/diffutils
  core/file
  core/fixesproto
  core/gcc
  core/kbproto
  core/libpthread-stubs
  core/libxfixes
  core/make
  core/pkg-config
  core/xextproto
  core/xproto
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  # The configure script expects `file` binaries to be in `/usr/bin`
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_end() {
  # Clean up
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
