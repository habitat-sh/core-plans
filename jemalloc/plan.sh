pkg_name=jemalloc
pkg_description="jemalloc"
pkg_upstream_url=http://www.canonware.com/jemalloc/
pkg_origin=core
pkg_version=4.2.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source=https://github.com/jemalloc/jemalloc/archive/${pkg_version}.tar.gz
pkg_shasum=38abd5c3798dee4bd0e63e082502358cd341b831b038bb443e89370df888a3eb
pkg_dirname=${pkg_name}-${pkg_version}
pkg_deps=(core/glibc)

pkg_build_deps=(
    core/autoconf
    core/coreutils
    core/gcc
    core/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_prepare() {
    autoconf
}

do_build() {
    ./configure --prefix=$pkg_prefix && make
}

do_install() {
    make install_bin install_include install_lib
    install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}
