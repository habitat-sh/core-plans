pkg_name=gobject-introspection
pkg_origin=core
pkg_version="1.68.0"
pkg_description="The goal of the project is to describe the APIs and collect them in a uniform, machine readable format"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://gi.readthedocs.io"
pkg_license=("LGPL-2.0")
pkg_source="https://gitlab.gnome.org/GNOME/${pkg_name}/-/archive/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="13595a257df7d0b71b002ec115f1faafd3295c9516f307e2c57bd219d5cd8369"
pkg_deps=(
  core/coreutils
  core/flex
  sirajrauff/glib
  core/glibc
  core/libffi
  core/pcre
  core/util-linux
  core/zlib
)
pkg_build_deps=(
  core/bison
  sirajrauff/meson
  core/ninja
  core/pkg-config
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_file=true
  fi
}

do_build() {
  meson _build --prefix=${pkg_prefix} \
    --buildtype release
  ninja -C _build
}

do_install() {
  ninja -C _build install
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/env
  fi
}

do_after() {
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}
