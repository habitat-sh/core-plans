pkg_name=libtalloc
pkg_origin=core
pkg_version="2.3.2"
pkg_upstream_url=https://talloc.samba.org
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Talloc is a hierarchical, reference counted memory pool system with destructors. It is the core memory allocator used in Samba."
pkg_license=("GPL-3.0")
pkg_source="https://www.samba.org/ftp/talloc/talloc-${pkg_version}.tar.gz"
pkg_dirname="talloc-${pkg_version}"
pkg_shasum="27a03ef99e384d779124df755deb229cd1761f945eca6d200e8cfd9bf5297bd7"
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

pkg_deps=(
  core/python
  core/glibc
)

pkg_build_deps=(
  core/gcc
  core/make
  core/coreutils
  core/pkg-config
  core/which
)

do_prepare() {
  if [[ ! -r /usr/bin/env ]]; then
   ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
  fi
}

do_end(){
  unlink /usr/bin/env
}

do_check(){
  make check
}
