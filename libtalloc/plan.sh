pkg_name=libtalloc
pkg_origin=core
pkg_version="2.1.12"
pkg_upstream_url=https://talloc.samba.org
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Talloc is a hierarchical, reference counted memory pool system with destructors. It is the core memory allocator used in Samba."
pkg_license=("GPL-3.0")
pkg_source="https://www.samba.org/ftp/talloc/talloc-${pkg_version}.tar.gz"
pkg_dirname="talloc-${pkg_version}"
pkg_shasum="987c0cf6815e948d20caaca04eba9b823e67773f361ffafe676e24b953cc604b"
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

pkg_build_deps=(
core/gcc
core/make
core/python2
core/coreutils
)

do_prepare() {
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
  fi
}

do_check(){
  make tests
}
