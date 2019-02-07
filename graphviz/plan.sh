pkg_name=graphviz
pkg_origin=core
pkg_version=2.40.1
pkg_license=("EPL-1.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Graphviz - Graph Visualization Software"
pkg_upstream_url="https://graphviz.gitlab.io/"
pkg_dirname="${pkg_name}-stable_release_${pkg_version}"
pkg_source="https://gitlab.com/graphviz/graphviz/-/archive/stable_release_${pkg_version}/${pkg_dirname}.tar.bz2"
pkg_shasum="92f654c95b412920777ceddf90e6564ffa871a77e4f6155ab437a2d3a2129e2b"
pkg_deps=(
  core/glibc
  core/libtool
)
pkg_build_deps=(
    core/autoconf
    core/automake
    core/bison
    core/coreutils
    core/diffutils
    core/flex
    core/gcc
    core/make
    core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_prepare() {
  # TODO: if we don't copy this aclocal will fail. need to figure out how to fix this
  cp "$(pkg_path_for core/pkg-config)/share/aclocal/pkg.m4" "$(pkg_path_for core/automake)/share/aclocal/"

  libtoolize
  ./autogen.sh
}

do_install() {
    make install
    install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}
