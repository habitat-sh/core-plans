pkg_name=libxdamage
pkg_origin=core
pkg_version=1.1.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 C Bindings"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_dirname="libXdamage-${pkg_version}"
pkg_source="https://www.x.org/releases/individual/lib/${pkg_dirname}.tar.bz2"
pkg_shasum="b734068643cac3b5f3d2c8279dd366b5bf28c7219d9e9d8717e1383995e0ea45"
pkg_deps=(
  core/glibc
  core/libxau
  core/libxcb
  core/libxdmcp
  core/libxfixes
  core/xlib
)
pkg_build_deps=(
  core/damageproto
  core/diffutils
  core/file
  core/fixesproto
  core/gcc
  core/kbproto
  core/libpthread-stubs
  core/make
  core/pkg-config
  core/util-macros
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
