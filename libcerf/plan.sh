pkg_name=libcerf
pkg_origin=core
pkg_version="1.17"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://jugit.fz-juelich.de/mlz/$pkg_name/-/archive/v$pkg_version/$pkg_name-v$pkg_version.tar.gz"
pkg_shasum="b1916b292cb37f2d0d0b699fbcf0fe260cca97ec7266ea20ff0c5cd8ef2eaab4"
pkg_dirname=${pkg_name}-v${pkg_version}
pkg_deps=(
  core/bzip2
  core/expat
  core/gcc-libs
  core/glibc
  core/jbigkit
  core/xz
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/make
  core/cmake
  core/perl
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="Libcerf is a self-contained numeric library that
provides an efficient and accurate implementation of complex error
functions, along with Dawson, Faddeeva, and Voigt functions"
pkg_upstream_url="http://apps.jcns.fz-juelich.de/doku/sc/libcerf"

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  mkdir -p build
  (
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX="$pkg_prefix"
    make
  )
}

do_install() {
  (
    cd build
    make install
  )
}


do_check() {
  (
    cd build
    make test
  )
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
