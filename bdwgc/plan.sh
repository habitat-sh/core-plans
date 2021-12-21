pkg_name=bdwgc
pkg_origin=core
pkg_version=8.0.6
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/ivmai/bdwgc/releases/download/v${pkg_version}/gc-${pkg_version}.tar.gz"
pkg_dirname="gc-${pkg_version}"
pkg_shasum=3b4914abc9fa76593596773e4da671d7ed4d5390e3d46fbf2e5f155e121bea11
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
