pkg_origin=core
pkg_name=pixman
pkg_description="A low-level software library for pixel manipulation"
pkg_upstream_url="http://pixman.org/"
pkg_version=0.40.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://www.cairographics.org/releases/pixman-${pkg_version}.tar.gz"
pkg_shasum=6d200dec3740d9ec4ec8d1180e25779c00bc749f94278c8b9021f5534db223fc
pkg_deps=(core/glibc core/gcc-libs core/libpng core/zlib)
pkg_build_deps=(core/gcc core/make core/pkg-config core/diffutils core/file)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
    if [[ ! -r /usr/bin/file ]]; then
        ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
        _clean_file=true
    fi
}

do_check() {
    make check
}

do_end() {
    if [[ -n "$_clean_file" ]]; then
        rm -fv /usr/bin/file
    fi
}
