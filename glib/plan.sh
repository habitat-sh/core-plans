pkg_origin=core
pkg_name=glib
pkg_version="2.68.0"
pkg_description="$(cat << EOF
  GLib is a general-purpose utility library, which provides many useful data
  types, macros, type conversions, string utilities, file utilities, a
  mainloop abstraction, and so on. It works on many UNIX-like platforms, as
  well as Windows and OS X.
EOF
)"
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_license=('LGPL-2.0')
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_upstream_url="https://developer.gnome.org/glib/"
pkg_shasum="67734f584f3a05a2872f57e9a8db38f3b06c7087fb531c5a839d9171968103ea"
pkg_deps=(
  core/coreutils
  core/elfutils
  core/glibc
  core/gcc-libs
  core/libffi
  core/libiconv
  core/pcre
  core/python
  core/util-linux
  core/zlib
)
pkg_build_deps=(
  core/dbus
  core/diffutils
  core/file
  core/gcc
  core/gettext
  core/libxslt
  core/meson
  core/perl
  core/pkg-config
  core/patchelf
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_interpreters=(core/coreutils)

do_build() {
  meson _build --prefix="$pkg_prefix" \
    -Diconv=external \
    -Dgtk_doc=false \
    --buildtype release
  ninja -C _build
}

do_install() {
  ninja -C _build install
}

do_after() {
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env

  # https://github.com/mesonbuild/meson/issues/6541
  # Is meson stripping rpath here?
  find "$pkg_prefix"/bin -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {}  \; \
    -exec patchelf --force-rpath --set-rpath "${LD_RUN_PATH}" {} \;

  for lib in "${pkg_lib_dirs[@]}"; do
    find "${pkg_prefix}/${lib}" -type f -executable \
      -exec sh -c 'file -i "$1" | grep -q "x-sharedlib; charset=binary"' _ {} \; \
      -exec patchelf --force-rpath --set-rpath "${LD_RUN_PATH}" {} \;
  done
}
