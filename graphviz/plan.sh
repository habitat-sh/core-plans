pkg_name=graphviz
pkg_origin=core
pkg_version=2.47.2
pkg_license=("EPL-1.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Graphviz - Graph Visualization Software"
pkg_upstream_url=https://graphviz.gitlab.io/
pkg_dirname="${pkg_name}-${pkg_version}"
pkg_source="https://gitlab.com/graphviz/graphviz/-/archive/${pkg_version}/graphviz-${pkg_version}.tar.gz"
pkg_shasum=0f55cc79326fc1ff37aacf1e26ac0cd0e8eb5656035a470c8fb8b103fb4d4af3
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
  core/git
  core/pkg-config
  core/python
  core/swig
  core/tcl
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_before() {
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for core/coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_prepare() {
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/pkg-config)/share/aclocal"
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/automake)/share/aclocal"
  ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/libtool)/share/aclocal"
  export ACLOCAL_PATH

  ./autogen.sh
}

do_install() {
  do_default_install
  install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}

do_end() {
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
