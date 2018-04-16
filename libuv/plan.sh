pkg_name=libuv
pkg_origin=core
pkg_version="1.20.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="http://dist.${pkg_name}.org/dist/v${pkg_version}/${pkg_name}-v${pkg_version}.tar.gz"
pkg_dirname="${pkg_name}-v${pkg_version}"
pkg_shasum="d19334d8db40cc92ace4b77bd0317d1c878e1a321afa2b7974f084dd3ed8b5e6"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/diffutils
  core/file
  core/gcc
  core/libtool
  core/m4
  core/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_description="libuv is a multi-platform support library with a focus on asynchronous I/O."
pkg_upstream_url="http://libuv.org/"

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  sh autogen.sh
  do_default_build
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

do_check() {
  make check
}
