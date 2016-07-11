pkg_name=freetype
pkg_version=2.6.3
pkg_origin=core
pkg_description="A software library to render fonts"
pkg_upstream_url="https://www.freetype.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('FreeType' 'GPL-2.0')
pkg_source=http://download.savannah.gnu.org/releases/freetype/${pkg_name}-${pkg_version}.tar.bz2
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=371e707aa522acf5b15ce93f11183c725b8ed1ee8546d7b3af549863045863a2
pkg_deps=(core/glibc core/libpng core/zlib core/bzip2)
pkg_build_deps=(core/gcc core/make core/coreutils core/pkg-config core/diffutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
    PKG_CONFIG_PATH="$(pkg_path_for zlib)/lib/pkgconfig"
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$(pkg_path_for libpng)/lib/pkgconfig"
    export PKG_CONFIG_PATH
    ./configure --prefix="$pkg_prefix"
    make
}
