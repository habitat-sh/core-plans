pkg_name=bdwgc
pkg_origin=core
pkg_version=8.0.4
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.hboehm.info/gc/gc_source/gc-${pkg_version}.tar.gz"
pkg_dirname="gc-${pkg_version}"
pkg_shasum="436a0ddc67b1ac0b0405b61a9675bca9e075c8156f4debd1d06f3a56c7cd289d"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/libatomic_ops
  core/make
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
