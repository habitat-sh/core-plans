pkg_name=gobject-introspection
pkg_origin=core
pkg_version=1.70.0
pkg_description="GObject Introspection is used to describe the program APIs and collect them in a uniform, machine readable format."
pkg_upstream_url="https://developer.gnome.org/gobject-introspection"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.0-or-later")
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=902b4906e3102d17aa2fcb6dad1c19971c70f2a82a159ddc4a94df73a3cafc4a
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/coreutils
)
pkg_build_deps=(
  core/gcc
  core/cmake
  core/pkg-config
  core/meson
  core/ninja
  core/bison
  core/flex
  core/git
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  build_line "Setting link for /usr/bin/env to 'coreutils'"
  if [ ! -f /usr/bin/env ]; then
    ln -s "$(pkg_interpreter_for core/coreutils bin/env)" /usr/bin/env
  fi
}

do_build() {
  mkdir build &&
  cd    build &&
  meson --prefix="$pkg_prefix" --buildtype=release .. &&
  ninja
}

do_install() {
   cd    build &&
   ninja install
}
