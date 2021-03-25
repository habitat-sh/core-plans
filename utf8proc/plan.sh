pkg_name=utf8proc
pkg_origin=core
pkg_version="2.6.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT-Expat")
pkg_description="A clean C library for processing UTF-8 Unicode data"
pkg_upstream_url=https://juliastrings.github.io/utf8proc/
pkg_source="https://github.com/JuliaStrings/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=8ff440b288b57b1d91dcbcf984a4bcfc8e5cf8089eb936be95055a0d1b174f43
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  make
  make prefix="${pkg_prefix}" install
}

do_check() {
  make check
}
