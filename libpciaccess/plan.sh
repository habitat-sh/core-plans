pkg_name=libpciaccess
pkg_origin=core
pkg_version=0.16
pkg_description="Direct Rendering Manager"
pkg_upstream_url="https://dri.freedesktop.org/wiki/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://www.x.org/archive/individual/lib/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=84413553994aef0070cf420050aa5c0a51b1956b404920e21b81e96db6a61a27
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/make
  core/pkg-config
  core/util-macros
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

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
