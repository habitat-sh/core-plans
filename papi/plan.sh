pkg_name=papi
pkg_origin=core
pkg_version=5.6.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Performance API"
pkg_upstream_url="http://icl.cs.utk.edu/papi/"
pkg_license=('BSD-3-Clause')
pkg_source="http://icl.utk.edu/projects/${pkg_name}/downloads/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="49b7293f9ca2d74d6d80bd06b5c4be303663123267b4ac0884cbcae4c914dc47"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/gcc7
  core/linux-headers
  core/make
  core/pkg-config
)
pkg_bin_dirs=(bin)
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
