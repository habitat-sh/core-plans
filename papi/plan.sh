pkg_name=papi
pkg_origin=core
pkg_version=5.5.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Performance API"
pkg_upstream_url="http://icl.cs.utk.edu/papi/"
pkg_license=('BSD-3-Clause')
pkg_source="http://icl.utk.edu/projects/${pkg_name}/downloads/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="49dc2c2323f6164c4a7e81b799ed690ee73158671205e71501f849391dd2c2d4"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/gcc
  core/linux-headers
  core/make
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  export LIBRARY_PATH
  LIBRARY_PATH="$(pkg_path_for core/glibc)/lib"
}

do_build() {
  pushd src > /dev/null
    do_default_build
  popd > /dev/null
}

do_install() {
  pushd src > /dev/null
    do_default_install
  popd > /dev/null
}
