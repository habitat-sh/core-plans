pkg_origin=core
pkg_name=snappy
pkg_version=1.1.0
pkg_dirname=snappy-bde324c0169763688f35ee44630a26ad1f49eec3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source=https://github.com/google/snappy/archive/bde324c0169763688f35ee44630a26ad1f49eec3.tar.gz
pkg_shasum=844091a82eb1e48b1e0fe599c3e59b767048f9db515ea83c8ff7fecc31e81331
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/autoconf core/automake core/pkg-config core/libtool core/m4 core/sed core/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build () {
 libtoolize --force
 ACLOCAL_PATH=$(pkg_path_for core/pkg-config)/share/aclocal autoreconf -iv
 ./configure --prefix=$pkg_prefix
 make
}

do_check () {
  make check
}
