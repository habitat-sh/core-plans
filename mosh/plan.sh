pkg_name=mosh
pkg_origin=core
pkg_version=1.2.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="Remote Terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and lines
editing of users keystrokes"
pkg_upstream_url="https://mosh.mit.edu"
pkg_source=https://mosh.mit.edu/mosh-${pkg_version}.tar.gz
pkg_shasum=1af809e5d747c333a852fbf7acdbf4d354dc4bbc2839e3afe5cf798190074be3
pkg_build_deps=(core/coreutils core/patch core/autoconf core/automake core/gcc core/make core/glibc core/protobuf core/zlib core/openssl core/pkg-config core/ncurses)
pkg_deps=(core/glibc core/gcc-libs)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
    PKG_CONFIG_PATH="$(pkg_path_for openssl)/lib/pkgconfig"
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$(pkg_path_for protobuf)/lib/pkgconfig"
    export PKG_CONFIG_PATH
    build_line "Setting PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
    ./configure --prefix="${pkg_prefix}"
    make
 }
