pkg_origin=core
pkg_name=glib
pkg_version="2.50.3"
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
pkg_shasum="82ee94bf4c01459b6b00cb9db0545c2237921e3060c0b74cff13fbc020cfd999"
pkg_deps=(
  core/coreutils
  core/glibc
  core/libffi
  core/libiconv
  core/pcre
  core/util-linux
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/gettext
  core/make
  core/pkg-config
  core/python
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_interpreters=(core/coreutils)

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-libiconv \
    --with-pcre=system \
    --disable-fam \
    --disable-gtk-doc \
    --enable-shared
  make
}

do_after() {
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}
