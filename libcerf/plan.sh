pkg_name=libcerf
pkg_origin=core
pkg_version="1.5"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="http://apps.jcns.fz-juelich.de/src/$pkg_name/$pkg_name-$pkg_version.tgz"
pkg_shasum="e36dc147e7fff81143074a21550c259b5aac1b99fc314fc0ae33294231ca5c86"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="Libcerf is a self-contained numeric library that
provides an efficient and accurate implementation of complex error
functions, along with Dawson, Faddeeva, and Voigt functions"
pkg_upstream_url="http://apps.jcns.fz-juelich.de/doku/sc/libcerf"

do_check() {
  make test
}
