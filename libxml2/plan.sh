pkg_name=libxml2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Libxml2 is the XML C parser and toolkit developed for the Gnome project"
pkg_upstream_url=http://xmlsoft.org/
pkg_origin=core
pkg_version=2.13.5
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://download.gnome.org/sources/${pkg_name}/2.13/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=74FC163217A3964257D3BE39AF943E08861263C4231F9EF5B496B6F6D4C7B2B6
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
