pkg_name=imagemagick
pkg_origin=core
pkg_version=6.9.2-10
pkg_description="A software suite to create, edit, compose, or convert bitmap images."
pkg_upstream_url="http://imagemagick.org/"
pkg_license=('Apache2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://www.imagemagick.org/download/releases/ImageMagick-${pkg_version}.tar.xz
pkg_shasum=da2f6fba43d69f20ddb11783f13f77782b0b57783dde9cda39c9e5e733c2013c
pkg_deps=(core/glibc core/zlib core/libpng core/xz core/gcc-libs)
pkg_build_deps=(core/zlib core/coreutils core/diffutils core/patch core/make core/gcc core/sed core/glibc core/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/ImageMagick-6)
pkg_lib_dirs=(lib)
pkg_dirname=ImageMagick-${pkg_version}

do_build() {
    PKG_CONFIG_PATH="$(pkg_path_for zlib)/lib/pkgconfig"
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$(pkg_path_for libpng)/lib/pkgconfig"
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$(pkg_path_for xz)/lib/pkgconfig"
    export PKG_CONFIG_PATH
    build_line "Setting PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
    CC="gcc -std=gnu99" ./configure --prefix=$pkg_prefix
    make
}
