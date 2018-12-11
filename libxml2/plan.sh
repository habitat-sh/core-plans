pkg_name=libxml2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Libxml2 is the XML C parser and toolkit developed for the Gnome project"
pkg_upstream_url=http://xmlsoft.org/
pkg_origin=core
pkg_version=2.9.8
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://xmlsoft.org/sources/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=0b74e51595654f958148759cfef0993114ddccccbb6f31aee018f3558e8e2732
pkg_deps=(core/zlib core/glibc)
pkg_build_deps=(core/coreutils core/make core/gcc core/m4)
pkg_filename=${pkg_name}-${pkg_version}.tar.xz
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix="$pkg_prefix" --without-python  --with-zlib="$(pkg_path_for zlib)"
  make
}
