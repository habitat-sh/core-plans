pkg_origin=core
pkg_name=pixman
pkg_description="A low-level software library for pixel manipulation"
pkg_version=0.34.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://www.cairographics.org/releases/pixman-${pkg_version}.tar.gz"
pkg_shasum=21b6b249b51c6800dc9553b65106e1e37d0e25df942c90531d4c3997aa20a88e
pkg_deps=(core/glibc core/gcc-libs core/libpng core/zlib)
pkg_build_deps=(core/gcc core/make core/pkg-config core/diffutils core/file)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

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
