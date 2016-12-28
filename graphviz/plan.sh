pkg_name=graphviz
pkg_description="Graphviz - Graph Visualization Software"
pkg_upstream_url=http://www.graphviz.org/
pkg_origin=core
pkg_version=2.38.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("EPL-1.0")
pkg_source=http://www.graphviz.org/pub/graphviz/stable/SOURCES/graphviz-${pkg_version}.tar.gz
pkg_shasum=81aa238d9d4a010afa73a9d2a704fc3221c731e1e06577c2ab3496bdef67859e
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
    make install
    install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}
