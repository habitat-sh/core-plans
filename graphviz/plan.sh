pkg_name=graphviz
pkg_origin=core
pkg_version=2.44.1
pkg_license=("EPL-1.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Graphviz - Graph Visualization Software"
pkg_upstream_url=https://graphviz.gitlab.io/
pkg_dirname="${pkg_name}-${pkg_version}"
pkg_source="https://www2.graphviz.org/Packages/stable/portable_source/graphviz-${pkg_version}.tar.gz"
pkg_shasum=8e1b34763254935243ccdb83c6ce108f531876d7a5dfd443f255e6418b8ea313
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
    core/git
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_prepare() {
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/pkg-config)/share/aclocal"
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/automake)/share/aclocal"
  export ACLOCAL_PATH

  ./autogen.sh
}

do_install() {
    make install
    install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}
